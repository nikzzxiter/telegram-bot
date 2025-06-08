#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <signal.h>
#include <pthread.h>

// Game process names
#define GAME_PROCESS_MAX "com.dts.freefiremax"
#define GAME_PROCESS_TH "com.dts.freefireth"

// Enhanced aim assist parameters
#define AIM_ASSIST_INTENSITY 8.0f      // Higher = stronger assist (1.0-10.0)
#define AIM_ASSIST_SMOOTHNESS 0.65f    // Lower = more snappy (0.1-1.0)
#define AIM_ASSIST_FOV 0.8f            // Field of view for detection (0.1-1.0)
#define AIM_ASSIST_DISTANCE_MAX 150.0f // Maximum distance for assist
#define AIM_ASSIST_HEADSHOT_BIAS 1.5f  // Bias towards headshots
#define TARGET_UPDATE_RATE_MS 16       // Target update rate (ms)
#define AIM_UPDATE_RATE_MS 8           // Aim update rate (ms)

// Vector structure for 3D coordinates
typedef struct {
    float x;
    float y;
    float z;
} Vector3;

// Quaternion structure for rotations
typedef struct {
    float x;
    float y;
    float z;
    float w;
} Quaternion;

// Player structure
typedef struct {
    Vector3 position;
    Vector3 velocity;
    Vector3 aimDirection;
    Quaternion rotation;
    float health;
    int isAiming;
    int isFiring;
    int weaponType;
    float recoilFactor;
} Player;

// Target structure
typedef struct {
    Vector3 position;
    Vector3 headPosition;
    Vector3 velocity;
    Vector3 direction;
    float distance;
    float health;
    int isVisible;
    int isBot;
    float threat;
    float lastSeenTime;
} Target;

// Game memory context
typedef struct {
    Player player;
    Target targets[16];
    int targetCount;
    char gameProcessName[64];
    pid_t gamePid;
    int isRunning;
    pthread_mutex_t mutex;
    pthread_t updateThread;
    pthread_t aimThread;
} GameContext;

// Global context
GameContext gameContext;
int shouldExit = 0;

// Forward declarations
void initGameContext(GameContext *context, const char *processName, pid_t pid);
void *memoryUpdateThread(void *arg);
void *aimAssistThread(void *arg);
void normalizeVector(Vector3 *vector);
float dotProduct(Vector3 v1, Vector3 v2);
float calculateDistance(Vector3 pos1, Vector3 pos2);
Vector3 calculateAimAssist(GameContext *context);
pid_t findGameProcess();
void handleSignal(int sig);

// Signal handler for clean exit
void handleSignal(int sig) {
    printf("\nExiting...\n");
    shouldExit = 1;
}

// Find game process ID
pid_t findGameProcess() {
    pid_t pid = 0;
    char command[256];
    char buffer[256];
    FILE *fp;

    // Try Free Fire MAX first
    sprintf(command, "pgrep -f %s", GAME_PROCESS_MAX);
    fp = popen(command, "r");
    if (fp != NULL) {
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {
            pid = atoi(buffer);
            pclose(fp);
            return pid;
        }
        pclose(fp);
    }

    // Try Free Fire TH next
    sprintf(command, "pgrep -f %s", GAME_PROCESS_TH);
    fp = popen(command, "r");
    if (fp != NULL) {
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {
            pid = atoi(buffer);
            pclose(fp);
            return pid;
        }
        pclose(fp);
    }

    return 0;
}

// Initialize the game context
void initGameContext(GameContext *context, const char *processName, pid_t pid) {
    // Set game process info
    strncpy(context->gameProcessName, processName, sizeof(context->gameProcessName) - 1);
    context->gameProcessName[sizeof(context->gameProcessName) - 1] = '\0';
    context->gamePid = pid;
    
    // Initialize player data with sensible defaults
    context->player.position = (Vector3){0.0f, 0.0f, 0.0f};
    context->player.velocity = (Vector3){0.0f, 0.0f, 0.0f};
    context->player.aimDirection = (Vector3){0.0f, 0.0f, 1.0f};
    context->player.rotation = (Quaternion){0.0f, 0.0f, 0.0f, 1.0f};
    context->player.health = 100.0f;
    context->player.isAiming = 0;
    context->player.isFiring = 0;
    context->player.weaponType = 0;
    context->player.recoilFactor = 0.0f;
    
    // Initialize target count
    context->targetCount = 0;
    
    // Initialize mutex
    pthread_mutex_init(&context->mutex, NULL);
    
    // Set running flag
    context->isRunning = 1;
    
    printf("[+] Game context initialized for %s (PID: %d)\n", processName, pid);
}

// Normalize a 3D vector
void normalizeVector(Vector3 *vector) {
    float length = sqrtf(vector->x * vector->x + vector->y * vector->y + vector->z * vector->z);
    if (length > 0.0001f) {
        vector->x /= length;
        vector->y /= length;
        vector->z /= length;
    }
}

// Calculate dot product of two vectors
float dotProduct(Vector3 v1, Vector3 v2) {
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

// Calculate distance between two positions
float calculateDistance(Vector3 pos1, Vector3 pos2) {
    float dx = pos2.x - pos1.x;
    float dy = pos2.y - pos1.y;
    float dz = pos2.z - pos1.z;
    return sqrtf(dx*dx + dy*dy + dz*dz);
}

// Simulate memory reading (would be replaced with actual memory access)
void simulateMemoryRead(GameContext *context) {
    static float time = 0.0f;
    time += 0.016f; // Simulate 16ms frame time
    
    // Update player position (simulated circular movement)
    context->player.position.x = sinf(time * 0.5f) * 5.0f;
    context->player.position.z = cosf(time * 0.5f) * 5.0f;
    
    // Update player aim direction
    context->player.aimDirection.x = sinf(time * 0.3f) * 0.1f;
    context->player.aimDirection.z = 1.0f;
    normalizeVector(&context->player.aimDirection);
    
    // Simulate some targets with movement
    context->targetCount = 5; // Fixed number for simulation
    
    for (int i = 0; i < context->targetCount; i++) {
        float angle = (float)i / context->targetCount * 2.0f * M_PI + time * (0.2f + i * 0.1f);
        float radius = 20.0f + i * 5.0f;
        
        // Target position moves in a circle around the player
        context->targets[i].position.x = sinf(angle) * radius;
        context->targets[i].position.y = 0.0f;
        context->targets[i].position.z = cosf(angle) * radius;
        
        // Head position is slightly above body position
        context->targets[i].headPosition = context->targets[i].position;
        context->targets[i].headPosition.y += 1.7f;
        
        // Calculate direction from player to target
        context->targets[i].direction.x = context->targets[i].position.x - context->player.position.x;
        context->targets[i].direction.y = context->targets[i].position.y - context->player.position.y;
        context->targets[i].direction.z = context->targets[i].position.z - context->player.position.z;
        normalizeVector(&context->targets[i].direction);
        
        // Calculate distance
        context->targets[i].distance = calculateDistance(context->player.position, context->targets[i].position);
        
        // Set other target properties
        context->targets[i].health = 100.0f - (i * 10.0f);
        context->targets[i].isVisible = (i % 3 != 0); // Some targets are not visible
        context->targets[i].isBot = (i % 2 == 0);     // Some targets are bots
        context->targets[i].threat = context->targets[i].isBot ? 0.5f : 1.0f;
        context->targets[i].lastSeenTime = time;
    }
}

// Find the best target for aim assist
int findBestTarget(GameContext *context) {
    int bestTargetIdx = -1;
    float bestScore = -1.0f;
    
    for (int i = 0; i < context->targetCount; i++) {
        // Skip targets that are not visible
        if (!context->targets[i].isVisible) continue;
        
        // Calculate dot product between aim direction and target direction
        float dot = dotProduct(context->player.aimDirection, context->targets[i].direction);
        
        // Only consider targets in the field of view
        if (dot > cosf(AIM_ASSIST_FOV * M_PI / 2.0f)) {
            // Distance factor (closer is better)
            float distanceFactor = 1.0f - (context->targets[i].distance / AIM_ASSIST_DISTANCE_MAX);
            if (distanceFactor < 0.0f) distanceFactor = 0.0f;
            
            // Threat factor
            float threatFactor = context->targets[i].threat;
            
            // Angle factor (more directly in front is better)
            float angleFactor = powf(dot, 2.0f);
            
            // Health factor (lower health targets are prioritized)
            float healthFactor = 1.0f - (context->targets[i].health / 100.0f) * 0.3f;
            
            // Calculate final score with weighted factors
            float score = distanceFactor * 0.4f + 
                         angleFactor * 0.3f + 
                         threatFactor * 0.2f + 
                         healthFactor * 0.1f;
            
            // If this target has a better score than previous best
            if (score > bestScore) {
                bestScore = score;
                bestTargetIdx = i;
            }
        }
    }
    
    return bestTargetIdx;
}

// Calculate aim assist vector
Vector3 calculateAimAssist(GameContext *context) {
    Vector3 result = context->player.aimDirection;
    
    // Find best target
    int bestTargetIdx = findBestTarget(context);
    if (bestTargetIdx >= 0) {
        Target *target = &context->targets[bestTargetIdx];
        
        // Determine aim point (head or body)
        Vector3 aimPoint;
        if (target->distance < 50.0f) {
            // At closer ranges, bias towards headshots
            aimPoint = target->headPosition;
        } else {
            // At longer ranges, aim for body
            aimPoint = target->position;
            aimPoint.y += 0.8f; // Aim at chest level
        }
        
        // Calculate direction to aim point
        Vector3 targetDirection;
        targetDirection.x = aimPoint.x - context->player.position.x;
        targetDirection.y = aimPoint.y - context->player.position.y;
        targetDirection.z = aimPoint.z - context->player.position.z;
        normalizeVector(&targetDirection);
        
        // Calculate aim assist strength based on distance
        float assistStrength = AIM_ASSIST_INTENSITY / 10.0f;
        
        // Reduce strength at very long ranges
        if (target->distance > 80.0f) {
            assistStrength *= (1.0f - (target->distance - 80.0f) / 70.0f);
            if (assistStrength < 0.1f) assistStrength = 0.1f;
        }
        
        // If player is actively aiming, increase assist strength
        if (context->player.isAiming) {
            assistStrength *= 1.5f;
        }
        
        // Apply smoothing based on smoothness factor
        float smoothFactor = AIM_ASSIST_SMOOTHNESS;
        
        // Linear interpolation between current aim and target direction
        result.x = context->player.aimDirection.x * smoothFactor + 
                  targetDirection.x * (1.0f - smoothFactor) * assistStrength;
        result.y = context->player.aimDirection.y * smoothFactor + 
                  targetDirection.y * (1.0f - smoothFactor) * assistStrength;
        result.z = context->player.aimDirection.z * smoothFactor + 
                  targetDirection.z * (1.0f - smoothFactor) * assistStrength;
        
        // Apply recoil compensation if firing
        if (context->player.isFiring && context->player.recoilFactor > 0.0f) {
            result.y -= context->player.recoilFactor * 0.01f;
        }
        
        normalizeVector(&result);
    }
    
    return result;
}

// Memory update thread
void *memoryUpdateThread(void *arg) {
    GameContext *context = (GameContext *)arg;
    
    while (!shouldExit && context->isRunning) {
        // Lock mutex to safely update game data
        pthread_mutex_lock(&context->mutex);
        
        // In a real implementation, this would read memory from the game process
        // For now, we'll use the simulation function
        simulateMemoryRead(context);
        
        // Unlock mutex
        pthread_mutex_unlock(&context->mutex);
        
        // Sleep for update interval
        usleep(TARGET_UPDATE_RATE_MS * 1000);
    }
    
    return NULL;
}

// Aim assist thread
void *aimAssistThread(void *arg) {
    GameContext *context = (GameContext *)arg;
    int frameCount = 0;
    
    while (!shouldExit && context->isRunning) {
        // Lock mutex to safely read game data
        pthread_mutex_lock(&context->mutex);
        
        // Calculate aim assist
        Vector3 aimAssistDirection = calculateAimAssist(context);
        
        // In a real implementation, this would write the new aim direction
        // back to the game's memory
        
        // Debug output every 60 frames (about once a second)
        frameCount++;
        if (frameCount % 60 == 0) {
            printf("[ACTIVE] Aim: (%.2f, %.2f, %.2f) | Targets: %d\n", 
                   aimAssistDirection.x, aimAssistDirection.y, aimAssistDirection.z,
                   context->targetCount);
        }
        
        // Unlock mutex
        pthread_mutex_unlock(&context->mutex);
        
        // Sleep for update interval (aim updates are more frequent than target updates)
        usleep(AIM_UPDATE_RATE_MS * 1000);
    }
    
    return NULL;
}

// Main function - streamlined for direct application
int main(int argc, char *argv[]) {
    // Setup signal handlers for clean exit
    signal(SIGINT, handleSignal);
    signal(SIGTERM, handleSignal);
    
    // Hide console noise
    printf("\033[2J\033[1;1H"); // Clear screen
    
    printf("============================================\n");
    printf("      FREE FIRE AIM ENHANCEMENT V2.0       \n");
    printf("============================================\n");
    
    // Find game process automatically
    pid_t gamePid = findGameProcess();
    if (gamePid == 0) {
        printf("[!] No Free Fire game detected. Starting monitor mode...\n");
        printf("[!] Launch Free Fire to activate enhancement.\n\n");
        
        // Wait for game to start
        while (!shouldExit && gamePid == 0) {
            gamePid = findGameProcess();
            sleep(1);
        }
        
        if (shouldExit) {
            return 0;
        }
    }
    
    // Determine which game is running
    char gameProcessName[64] = {0};
    char command[256];
    char buffer[256];
    FILE *fp;
    
    sprintf(command, "ps -p %d -o comm=", gamePid);
    fp = popen(command, "r");
    if (fp != NULL) {
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {
            buffer[strcspn(buffer, "\n")] = 0;
            strncpy(gameProcessName, buffer, sizeof(gameProcessName) - 1);
        }
        pclose(fp);
    }
    
    if (strstr(gameProcessName, GAME_PROCESS_MAX) != NULL) {
        printf("[+] Detected: Free Fire MAX (PID: %d)\n", gamePid);
        initGameContext(&gameContext, GAME_PROCESS_MAX, gamePid);
    } else if (strstr(gameProcessName, GAME_PROCESS_TH) != NULL) {
        printf("[+] Detected: Free Fire TH (PID: %d)\n", gamePid);
        initGameContext(&gameContext, GAME_PROCESS_TH, gamePid);
    } else {
        printf("[!] Unknown game process: %s\n", gameProcessName);
        return 1;
    }
    
    printf("[+] Enhancement settings:\n");
    printf("    > Intensity: %.1f/10.0\n", AIM_ASSIST_INTENSITY);
    printf("    > Smoothness: %.1f/1.0\n", AIM_ASSIST_SMOOTHNESS);
    printf("    > Detection FOV: %.1f\n", AIM_ASSIST_FOV);
    printf("    > Maximum distance: %.1fm\n", AIM_ASSIST_DISTANCE_MAX);
    printf("    > Update rate: %dms\n", AIM_UPDATE_RATE_MS);
    printf("\n[*] Enhancement active! Press Ctrl+C to exit.\n\n");
    
    // Start memory update thread
    pthread_create(&gameContext.updateThread, NULL, memoryUpdateThread, &gameContext);
    
    // Start aim assist thread
    pthread_create(&gameContext.aimThread, NULL, aimAssistThread, &gameContext);
    
    // Main thread waits for threads to complete
    pthread_join(gameContext.updateThread, NULL);
    pthread_join(gameContext.aimThread, NULL);
    
    // Clean up
    pthread_mutex_destroy(&gameContext.mutex);
    
    printf("\n[*] Enhancement deactivated. Goodbye!\n");
    
    return 0;
}