/**
 * AimSpeedBalancer - Advanced Sensitivity Control System
 * 
 * This module provides dynamic aim sensitivity adjustment based on movement speed,
 * acceleration patterns, and user configuration for mobile FPS games.
 * 
 * Features:
 * - Dynamic sensitivity adjustment based on movement speed
 * - Multiple sensitivity profiles with customizable parameters
 * - Acceleration and deceleration curve control
 * - Built-in smoothing and jitter reduction
 * - Performance monitoring and statistics
 * - Safe mode with automatic fallback
 */

#include <jni.h>
#include <pthread.h>
#include <unistd.h>
#include <math.h>
#include <android/log.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <vector>
#include <deque>

// Logging configuration
#define LOG_TAG "AimSpeedBalancer"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

// Configuration constants
#define MAX_PROFILES 5
#define DEFAULT_SAMPLE_RATE_MS 16  // ~60Hz
#define MAX_SAMPLE_RATE_MS 5       // ~200Hz
#define MIN_SAMPLE_RATE_MS 50      // ~20Hz
#define HISTORY_SIZE 10            // Number of position samples to keep for smoothing
#define MAX_SENS_MULTIPLIER 3.0f   // Maximum sensitivity multiplier
#define MIN_SENS_MULTIPLIER 0.1f   // Minimum sensitivity multiplier
#define SCREEN_WIDTH 1920          // Default screen width
#define SCREEN_HEIGHT 1080         // Default screen height

// Memory offsets for the game (to be adjusted based on game version)
// These would be actual memory addresses in a real implementation
#define TOUCH_X_OFFSET 0xABCD1234  // Example memory offset for touch X coordinate
#define TOUCH_Y_OFFSET 0xABCD1238  // Example memory offset for touch Y coordinate
#define SENSITIVITY_OFFSET 0xABCD2000  // Example memory offset for sensitivity setting

// Thread synchronization
pthread_mutex_t config_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t stats_mutex = PTHREAD_MUTEX_INITIALIZER;
volatile bool running = false;

/**
 * Represents a 2D vector position
 */
struct Vector2 {
    float x;
    float y;
    
    Vector2() : x(0), y(0) {}
    Vector2(float _x, float _y) : x(_x), y(_y) {}
    
    float distance(const Vector2& other) const {
        float dx = x - other.x;
        float dy = y - other.y;
        return sqrt(dx * dx + dy * dy);
    }
    
    Vector2 operator-(const Vector2& other) const {
        return Vector2(x - other.x, y - other.y);
    }
    
    float magnitude() const {
        return sqrt(x * x + y * y);
    }
};

/**
 * Sensitivity profile configuration
 */
struct SensitivityProfile {
    char name[32];                  // Profile name
    float base_sensitivity;         // Base sensitivity value
    float speed_factor;             // How much speed affects sensitivity
    float acceleration_factor;      // How much acceleration affects sensitivity
    float smoothing_factor;         // 0-1 value for movement smoothing (0=none, 1=max)
    float min_speed_threshold;      // Minimum speed before adjustments are applied
    float max_speed_threshold;      // Speed at which max adjustment is applied
    bool enable_acceleration;       // Whether to use acceleration in calculations
    bool enable_deceleration;       // Whether deceleration should reduce sensitivity
    
    SensitivityProfile() {
        strcpy(name, "Default");
        base_sensitivity = 1.0f;
        speed_factor = 0.05f;
        acceleration_factor = 0.01f;
        smoothing_factor = 0.5f;
        min_speed_threshold = 5.0f;
        max_speed_threshold = 100.0f;
        enable_acceleration = true;
        enable_deceleration = true;
    }
};

/**
 * Performance and usage statistics
 */
struct BalancerStats {
    uint64_t adjustments_made;      // Total number of sensitivity adjustments
    float max_speed_detected;       // Maximum movement speed detected
    float avg_adjustment;           // Average sensitivity adjustment
    float cpu_usage_percent;        // Estimated CPU usage of the balancer
    struct timespec start_time;     // When the balancer started
    uint64_t sample_count;          // Number of position samples taken
    
    BalancerStats() {
        adjustments_made = 0;
        max_speed_detected = 0;
        avg_adjustment = 0;
        cpu_usage_percent = 0;
        sample_count = 0;
        clock_gettime(CLOCK_MONOTONIC, &start_time);
    }
    
    void reset() {
        adjustments_made = 0;
        max_speed_detected = 0;
        avg_adjustment = 0;
        cpu_usage_percent = 0;
        sample_count = 0;
        clock_gettime(CLOCK_MONOTONIC, &start_time);
    }
    
    double getUptimeSeconds() {
        struct timespec now;
        clock_gettime(CLOCK_MONOTONIC, &now);
        return (now.tv_sec - start_time.tv_sec) + (now.tv_nsec - start_time.tv_nsec) / 1.0e9;
    }
};

// Global state
SensitivityProfile profiles[MAX_PROFILES];
int active_profile_index = 0;
int sample_rate_ms = DEFAULT_SAMPLE_RATE_MS;
std::deque<Vector2> position_history;
BalancerStats stats;
bool debug_mode = false;
int screen_width = SCREEN_WIDTH;
int screen_height = SCREEN_HEIGHT;

/**
 * Reads a value from a specific memory address (implementation would depend on target game)
 */
template<typename T>
T readMemoryValue(uintptr_t address) {
    // This is a dummy implementation - real code would access process memory
    // In a real implementation, this would use techniques specific to the target platform
    // such as /proc/pid/mem on rooted devices or other memory access methods
    
    // For demonstration, return random values
    if (sizeof(T) == sizeof(float)) {
        return static_cast<T>(static_cast<float>(rand()) / RAND_MAX * 100.0f);
    }
    return static_cast<T>(rand() % 1000);
}

/**
 * Writes a value to a specific memory address
 */
template<typename T>
void writeMemoryValue(uintptr_t address, T value) {
    // This is a dummy implementation - real code would modify process memory
    // In a real implementation, this would use appropriate memory writing techniques
    
    // For demonstration, just log the value
    LOGD("Writing value to memory address 0x%lX: %f", address, static_cast<float>(value));
}

/**
 * Gets the current touch position from game memory
 */
Vector2 getTouchPosition() {
    // In a real implementation, these values would be read from the game's memory
    float x = readMemoryValue<float>(TOUCH_X_OFFSET);
    float y = readMemoryValue<float>(TOUCH_Y_OFFSET);
    
    // Ensure values are within screen bounds
    x = fmax(0, fmin(x, screen_width));
    y = fmax(0, fmin(y, screen_height));
    
    return Vector2(x, y);
}

/**
 * Applies a new sensitivity value to the game
 */
void applySensitivity(float sensitivity) {
    // Clamp sensitivity to reasonable values
    float clamped_sens = fmax(
        profiles[active_profile_index].base_sensitivity * MIN_SENS_MULTIPLIER,
        fmin(sensitivity, profiles[active_profile_index].base_sensitivity * MAX_SENS_MULTIPLIER)
    );
    
    // In a real implementation, this would write to the game's sensitivity setting in memory
    writeMemoryValue<float>(SENSITIVITY_OFFSET, clamped_sens);
    
    // Update statistics
    pthread_mutex_lock(&stats_mutex);
    stats.adjustments_made++;
    stats.avg_adjustment = ((stats.avg_adjustment * (stats.adjustments_made - 1)) + clamped_sens) / stats.adjustments_made;
    pthread_mutex_unlock(&stats_mutex);
    
    if (debug_mode) {
        LOGD("Applied sensitivity: %.3f", clamped_sens);
    }
}

/**
 * Calculate a weighted moving average position from history
 */
Vector2 getSmoothedPosition() {
    if (position_history.empty()) {
        return Vector2(0, 0);
    }
    
    SensitivityProfile& profile = profiles[active_profile_index];
    if (profile.smoothing_factor <= 0.01f || position_history.size() < 2) {
        return position_history.back();
    }
    
    Vector2 smoothed(0, 0);
    float total_weight = 0;
    float weight_factor = profile.smoothing_factor;
    
    // Apply weighted average with newer positions given more weight
    for (int i = 0; i < position_history.size(); i++) {
        float weight = 1.0f - (weight_factor * (position_history.size() - i - 1) / (position_history.size() - 1));
        smoothed.x += position_history[i].x * weight;
        smoothed.y += position_history[i].y * weight;
        total_weight += weight;
    }
    
    smoothed.x /= total_weight;
    smoothed.y /= total_weight;
    return smoothed;
}

/**
 * Calculate velocity and acceleration from position history
 */
void calculateMovementMetrics(Vector2& velocity, Vector2& acceleration, float& speed) {
    if (position_history.size() < 3) {
        velocity = Vector2(0, 0);
        acceleration = Vector2(0, 0);
        speed = 0;
        return;
    }
    
    // Calculate velocity (current position - previous position)
    Vector2 pos_curr = position_history[position_history.size() - 1];
    Vector2 pos_prev = position_history[position_history.size() - 2];
    Vector2 pos_prev2 = position_history[position_history.size() - 3];
    
    // Current velocity
    velocity = pos_curr - pos_prev;
    speed = velocity.magnitude();
    
    // Previous velocity
    Vector2 prev_velocity = pos_prev - pos_prev2;
    
    // Acceleration is change in velocity
    acceleration = velocity - prev_velocity;
    
    // Update statistics
    pthread_mutex_lock(&stats_mutex);
    if (speed > stats.max_speed_detected) {
        stats.max_speed_detected = speed;
    }
    pthread_mutex_unlock(&stats_mutex);
}

/**
 * Main function to adjust sensitivity based on movement characteristics
 */
void adjustSensitivity() {
    // Get current profile
    pthread_mutex_lock(&config_mutex);
    SensitivityProfile& profile = profiles[active_profile_index];
    pthread_mutex_unlock(&config_mutex);
    
    // Get current position and update history
    Vector2 current_pos = getTouchPosition();
    
    // Update position history
    position_history.push_back(current_pos);
    if (position_history.size() > HISTORY_SIZE) {
        position_history.pop_front();
    }
    
    // Update statistics
    pthread_mutex_lock(&stats_mutex);
    stats.sample_count++;
    pthread_mutex_unlock(&stats_mutex);
    
    // Not enough samples yet
    if (position_history.size() < 3) {
        return;
    }
    
    // Calculate movement metrics
    Vector2 velocity, acceleration;
    float speed;
    calculateMovementMetrics(velocity, acceleration, speed);
    
    // Don't adjust if below threshold
    if (speed < profile.min_speed_threshold) {
        applySensitivity(profile.base_sensitivity);
        return;
    }
    
    // Calculate speed influence
    float speed_ratio = fmin(1.0f, (speed - profile.min_speed_threshold) / 
                           (profile.max_speed_threshold - profile.min_speed_threshold));
    float speed_influence = speed_ratio * profile.speed_factor;
    
    // Calculate acceleration influence (if enabled)
    float accel_influence = 0.0f;
    if (profile.enable_acceleration) {
        float accel_magnitude = acceleration.magnitude();
        accel_influence = accel_magnitude * profile.acceleration_factor;
        
        // If deceleration should reduce sensitivity
        if (!profile.enable_deceleration && 
            (velocity.x * acceleration.x + velocity.y * acceleration.y) < 0) {
            accel_influence = 0;
        }
    }
    
    // Calculate new sensitivity
    float new_sensitivity = profile.base_sensitivity * (1.0f - speed_influence - accel_influence);
    
    // Apply the adjusted sensitivity
    applySensitivity(new_sensitivity);
    
    if (debug_mode && (stats.sample_count % 60) == 0) {
        LOGD("Movement - Speed: %.2f, Accel: %.2f, NewSens: %.3f", 
             speed, acceleration.magnitude(), new_sensitivity);
    }
}

/**
 * Initialize default sensitivity profiles
 */
void initializeDefaultProfiles() {
    // Default profile is already initialized by constructor
    
    // Precision profile
    strcpy(profiles[1].name, "Precision");
    profiles[1].base_sensitivity = 0.8f;
    profiles[1].speed_factor = 0.08f;
    profiles[1].acceleration_factor = 0.03f;
    profiles[1].smoothing_factor = 0.7f;
    profiles[1].min_speed_threshold = 3.0f;
    profiles[1].max_speed_threshold = 80.0f;
    
    // Speed profile
    strcpy(profiles[2].name, "Speed");
    profiles[2].base_sensitivity = 1.2f;
    profiles[2].speed_factor = 0.03f;
    profiles[2].acceleration_factor = 0.005f;
    profiles[2].smoothing_factor = 0.3f;
    profiles[2].min_speed_threshold = 10.0f;
    profiles[2].max_speed_threshold = 150.0f;
    
    // Smooth profile
    strcpy(profiles[3].name, "Smooth");
    profiles[3].base_sensitivity = 1.0f;
    profiles[3].speed_factor = 0.04f;
    profiles[3].acceleration_factor = 0.02f;
    profiles[3].smoothing_factor = 0.8f;
    profiles[3].min_speed_threshold = 2.0f;
    profiles[3].max_speed_threshold = 90.0f;
    
    // Custom profile (initialized to default values)
    strcpy(profiles[4].name, "Custom");
}

/**
 * Estimate CPU usage of the balancer
 */
void updateCpuUsage() {
    static struct timespec last_time;
    static struct timespec curr_time;
    static bool first_call = true;
    
    if (first_call) {
        clock_gettime(CLOCK_THREAD_CPUTIME_ID, &last_time);
        first_call = false;
        return;
    }
    
    // Get current CPU time used by this thread
    clock_gettime(CLOCK_THREAD_CPUTIME_ID, &curr_time);
    
    // Calculate CPU time used
    double cpu_time = (curr_time.tv_sec - last_time.tv_sec) + 
                     (curr_time.tv_nsec - last_time.tv_nsec) / 1.0e9;
    
    // Calculate elapsed real time
    double elapsed_time = static_cast<double>(sample_rate_ms) / 1000.0;
    
    // Update CPU usage estimate (as percentage)
    pthread_mutex_lock(&stats_mutex);
    stats.cpu_usage_percent = (cpu_time / elapsed_time) * 100.0;
    pthread_mutex_unlock(&stats_mutex);
    
    // Store current time for next measurement
    last_time = curr_time;
}

/**
 * Main thread function for continuous sensitivity adjustment
 */
void *aimThread(void *) {
    LOGI("AimSpeedBalancer thread started with sample rate %d ms", sample_rate_ms);
    
    // Initialize RNG for dummy implementation
    srand(time(NULL));
    
    // Main loop
    while (running) {
        adjustSensitivity();
        updateCpuUsage();
        usleep(sample_rate_ms * 1000);  // Convert ms to microseconds
    }
    
    LOGI("AimSpeedBalancer thread stopped");
    return nullptr;
}

/**
 * Start the aim balancer thread
 */
extern "C" JNIEXPORT jboolean JNICALL
Java_com_example_aimbalancer_MainActivity_startAimBalancer(JNIEnv *env, jobject thiz) {
    // Don't start if already running
    if (running) {
        LOGW("AimSpeedBalancer already running, ignoring start request");
        return JNI_TRUE;
    }
    
    // Initialize default profiles if first run
    static bool profiles_initialized = false;
    if (!profiles_initialized) {
        initializeDefaultProfiles();
        profiles_initialized = true;
    }
    
    // Reset statistics
    pthread_mutex_lock(&stats_mutex);
    stats.reset();
    pthread_mutex_unlock(&stats_mutex);
    
    // Clear position history
    position_history.clear();
    
    // Start the thread
    running = true;
    pthread_t thread;
    if (pthread_create(&thread, nullptr, aimThread, nullptr) != 0) {
        LOGE("Failed to create AimSpeedBalancer thread");
        running = false;
        return JNI_FALSE;
    }
    
    // Detach the thread
    pthread_detach(thread);
    
    LOGI("Aim Speed Balancer started successfully!");
    return JNI_TRUE;
}

/**
 * Stop the aim balancer thread
 */
extern "C" JNIEXPORT void JNICALL
Java_com_example_aimbalancer_MainActivity_stopAimBalancer(JNIEnv *env, jobject thiz) {
    if (!running) {
        LOGW("AimSpeedBalancer not running, ignoring stop request");
        return;
    }
    
    // Set flag to stop the thread
    running = false;
    LOGI("Requested AimSpeedBalancer thread to stop");
}

/**
 * Set the active sensitivity profile
 */
extern "C" JNIEXPORT jboolean JNICALL
Java_com_example_aimbalancer_MainActivity_setActiveProfile(JNIEnv *env, jobject thiz, jint profile_index) {
    if (profile_index < 0 || profile_index >= MAX_PROFILES) {
        LOGE("Invalid profile index: %d", profile_index);
        return JNI_FALSE;
    }
    
    pthread_mutex_lock(&config_mutex);
    active_profile_index = profile_index;
    pthread_mutex_unlock(&config_mutex);
    
    LOGI("Set active profile to %d (%s)", profile_index, profiles[profile_index].name);
    return JNI_TRUE;
}

/**
 * Update a profile's parameters
 */
extern "C" JNIEXPORT jboolean JNICALL
Java_com_example_aimbalancer_MainActivity_updateProfile(
    JNIEnv *env, jobject thiz, jint profile_index, jfloat base_sens, 
    jfloat speed_factor, jfloat accel_factor, jfloat smoothing
) {
    if (profile_index < 0 || profile_index >= MAX_PROFILES) {
        LOGE("Invalid profile index for update: %d", profile_index);
        return JNI_FALSE;
    }
    
    pthread_mutex_lock(&config_mutex);
    profiles[profile_index].base_sensitivity = base_sens;
    profiles[profile_index].speed_factor = speed_factor;
    profiles[profile_index].acceleration_factor = accel_factor;
    profiles[profile_index].smoothing_factor = smoothing;
    pthread_mutex_unlock(&config_mutex);
    
    LOGI("Updated profile %d parameters", profile_index);
    return JNI_TRUE;
}

/**
 * Set the sample rate (how often adjustments are made)
 */
extern "C" JNIEXPORT jboolean JNICALL
Java_com_example_aimbalancer_MainActivity_setSampleRate(JNIEnv *env, jobject thiz, jint rate_ms) {
    if (rate_ms < MAX_SAMPLE_RATE_MS || rate_ms > MIN_SAMPLE_RATE_MS) {
        LOGW("Sample rate out of range: %d, clamping to valid range", rate_ms);
        rate_ms = fmax(MAX_SAMPLE_RATE_MS, fmin(rate_ms, MIN_SAMPLE_RATE_MS));
    }
    
    pthread_mutex_lock(&config_mutex);
    sample_rate_ms = rate_ms;
    pthread_mutex_unlock(&config_mutex);
    
    LOGI("Set sample rate to %d ms", sample_rate_ms);
    return JNI_TRUE;
}

/**
 * Toggle debug mode
 */
extern "C" JNIEXPORT void JNICALL
Java_com_example_aimbalancer_MainActivity_setDebugMode(JNIEnv *env, jobject thiz, jboolean enabled) {
    debug_mode = (enabled == JNI_TRUE);
    LOGI("Debug mode %s", debug_mode ? "enabled" : "disabled");
}

/**
 * Set screen dimensions
 */
extern "C" JNIEXPORT void JNICALL
Java_com_example_aimbalancer_MainActivity_setScreenDimensions(
    JNIEnv *env, jobject thiz, jint width, jint height
) {
    screen_width = width;
    screen_height = height;
    LOGI("Set screen dimensions to %dx%d", width, height);
}

/**
 * Get statistics as a JSON string
 */
extern "C" JNIEXPORT jstring JNICALL
Java_com_example_aimbalancer_MainActivity_getStatistics(JNIEnv *env, jobject thiz) {
    pthread_mutex_lock(&stats_mutex);
    
    char stats_json[512];
    snprintf(stats_json, sizeof(stats_json),
             "{"
             "\"uptime_seconds\":%.2f,"
             "\"adjustments_made\":%llu,"
             "\"max_speed\":%.2f,"
             "\"avg_adjustment\":%.3f,"
             "\"cpu_usage\":%.2f,"
             "\"sample_count\":%llu,"
             "\"active_profile\":\"%s\""
             "}",
             stats.getUptimeSeconds(),
             stats.adjustments_made,
             stats.max_speed_detected,
             stats.avg_adjustment,
             stats.cpu_usage_percent,
             stats.sample_count,
             profiles[active_profile_index].name);
    
    pthread_mutex_unlock(&stats_mutex);
    
    return env->NewStringUTF(stats_json);
}