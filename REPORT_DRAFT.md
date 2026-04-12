# DEVOPS PROJECT REPORT: 36. DOCKER NETWORKING WITH ISOLATED CONTAINERS
## Title: Secure 3-Tier Enterprise Placement Platform with Docker Microservices and Network Isolation

---

### 1. Report Index Page
1. Aim
2. Abstract
3. Scope & Objectives
4. Hardware & Software Requirements
5. Project Design (Placement Platform Architecture)
6. Advantages
7. Proposed System
8. Implementation of the Project
9. Output Screenshots
10. Conclusion
11. Coding/Commands
12. Mastering DevOps Course Completion Certificate

### 2. Bonafide Certificate
(To be provided by the Department)

### 3. Aim
To design and implement a secure Docker networking strategy that isolates sensitive services while enabling controlled communication between microservices, using a 3-tier enterprise placement platform as the core application.

### 4. Abstract
This project addresses the security scenario where an organization needs to ensure secure communication between containers while isolating critical services like databases. We have architected a "Track Placement Preparation" platform using a 3-tier microservices model (Frontend, Backend, and Database). The innovation lies in the **Docker Network Segmentation**: we created custom bridge networks (`app-network` and `db-network`) to ensure the Database is completely isolated from the public-facing frontend tier. The project includes automated testing scripts to verify this isolation, fulfilling all requirements of the "Docker Networking with Isolated Containers" objective.

### 5. Scope & Objectives
- **Scope**: Enterprise-grade microservices security and container orchestration.
- **Objectives**:
  - Implement a 3-tier containerized architecture.
  - Create **Custom Docker Networks** for traffic segmentation.
  - Run containers in **Isolated Networks** (VPC-like structure).
  - Enable **Controlled Communication** using a dual-homed backend bridge.
  - Provide a **Demonstration Script** to test and verify network isolation.

### 6. Hardware & Software Requirements
- **Hardware**: Minimum 4GB RAM, 20GB Disk Space, Dual-core CPU.
- **Software**: 
  - Operating System: Windows 10/11 or Linux.
  - Docker Desktop / Docker Engine.
  - Node.js (v18+).
  - MongoDB Engine.
  - Bash/Shell for testing.

### 7. Project Design
**Architecture Diagram**:
`[User Browser] -> [Nginx (Frontend Network)] -> [Node.js API (Frontend & DB Network)] -> [MongoDB (DB Network - Isolated)]`
- **Frontend Tier**: Nginx + React. Handles public HTTP traffic.
- **Backend Tier**: Node.js Express API. Acts as the secure bridge between networks.
- **Database Tier**: MongoDB. Stores sensitive student data in a completely isolated environment.

### 8. Advantages
- **Enhanced Security**: The database tier has no physical network path to the internet or the frontend.
- **Reduced Attack Surface**: Hackers who breach the frontend cannot "hop" to the database.
- **Zero CORS Issues**: Nginx acts as a reverse proxy, routing all traffic through a single port.
- **Data Persistence**: Student records are safe in persistent Docker volumes.

### 9. Proposed System
The proposed system uses "Defense in Depth" networking. Unlike standard single-network Docker setups, this system uses multiple bridge networks. It implements the principle of least privilege, where each container only has access to the networks it strictly needs for its specific function.

### 10. Implementation of the Project
- **Network Creation**: Defined `app-network` and `db-network` in Docker Compose.
- **Isolation Strategy**: 
  - Frontend container assigned only to `app-network`.
  - Database container assigned only to `db-network`.
  - Backend container assigned to BOTH, enabling it to proxy data securely.
- **Reverse Proxy**: Configured Nginx to route `/api/` calls to the backend via the internal DNS name.
- **Testing**: Developed `test_isolation.sh` to programmatically verify that isolation is active.

### 11. Output Screenshots
(User to attach screenshots of: `test_isolation.sh` results, `docker network ls`, Dashboard UI).

### 12. Conclusion
The project successfully fulfills the requirement for "Docker Networking with Isolated Containers." We have demonstrated that by using custom bridge networks and strategic container placement, we can build complex, multi-tier applications that are secure by design.

### 13. Coding/Commands
- **Deployment**: `docker-compose up -d --build`
- **Isolation Test**: `bash test_isolation.sh`
- **Network Inspection**: `docker network inspect db-network`
- **Check Status**: `docker-compose ps`

### 14. Certificate
(Mastering DevOps Course Completion Certificate)
