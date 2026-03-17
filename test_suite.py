import subprocess
import json
import time
from datetime import datetime

class DockerNetworkTester:
    def __init__(self):
        self.results = {
            "timestamp": datetime.now().isoformat(),
            "tests": []
        }

    def run_ping(self, source, target, expected_success=True):
        print(f"Testing: {source} -> {target} (Expected: {'Success' if expected_success else 'Failure'})")
        cmd = ["docker", "exec", source, "ping", "-c", "2", "-W", "2", target]
        
        try:
            process = subprocess.run(cmd, capture_output=True, text=True)
            success = process.returncode == 0
        except Exception as e:
            success = False
            print(f"Error executing command: {e}")

        test_passed = (success == expected_success)
        
        self.results["tests"].append({
            "source": source,
            "target": target,
            "expected": "success" if expected_success else "failure",
            "actual": "success" if success else "failure",
            "passed": test_passed
        })
        
        status = "PASSED" if test_passed else "FAILED"
        print(f"Result: {status}\n")
        return test_passed

    def save_report(self):
        with open("test_report.json", "w") as f:
            json.dump(self.results, f, indent=4)
        print("Detailed report saved to test_report.json")

if __name__ == "__main__":
    tester = DockerNetworkTester()
    
    # 1. Start stack
    print("Deploying stack...")
    subprocess.run(["docker-compose", "up", "-d"])
    
    # Wait for containers to be ready
    print("Waiting for containers to initialize...")
    time.sleep(5)

    # 2. Run Tests
    # Frontend -> Backend: Success
    tester.run_ping("frontend-service", "backend-service", expected_success=True)
    
    # Frontend -> DB: Failure (Isolation)
    tester.run_ping("frontend-service", "db-service", expected_success=False)
    
    # Backend -> DB: Success
    tester.run_ping("backend-service", "db-service", expected_success=True)
    
    # DB -> Frontend: Failure (Isolation)
    tester.run_ping("db-service", "frontend-service", expected_success=False)

    # 3. Save & Cleanup
    tester.save_report()
    
    print("Cleaning up...")
    subprocess.run(["docker-compose", "down"])
