# 🔐 Secure CI/CD Pipeline Demo

A demonstration of a security-hardened CI/CD pipeline using GitHub Actions, integrating automated security gates for container scanning and static code analysis before deployment.

---

## 📌 Overview

This project showcases DevSecOps best practices by embedding security tools directly into the CI/CD pipeline. Instead of treating security as an afterthought, every code push triggers automated vulnerability scans and code quality checks before any image is built or deployed.

---

## 🏗️ Architecture

```
Code Push / PR
      │
      ▼
┌─────────────────────┐
│  GitHub Actions CI  │
└─────────────────────┘
      │
      ├──▶ SonarQube (SAST — Static Code Analysis)
      │         └── Fails build on critical issues
      │
      ├──▶ Docker Build
      │
      ├──▶ Trivy (Container Image Scanning)
      │         └── Scans for known CVEs (CRITICAL/HIGH)
      │         └── Fails build if vulnerabilities found
      │
      └──▶ Deploy (only if all gates pass)
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **GitHub Actions** | CI/CD orchestration |
| **Docker** | Containerization |
| **Trivy** | Container image vulnerability scanning |
| **SonarQube** | Static Application Security Testing (SAST) |
| **Node.js** | Sample application |

---

## 🔒 Security Gates

### 1. Static Code Analysis (SonarQube)
- Scans source code for security hotspots, code smells, and bugs
- Blocks the pipeline if critical or blocker issues are detected
- Enforces secure coding standards (OWASP Top 10 alignment)

### 2. Container Image Scanning (Trivy)
- Scans the built Docker image for known CVEs
- Checks OS packages, application dependencies, and misconfigurations
- Pipeline fails automatically on CRITICAL or HIGH severity findings

---

## 📁 Project Structure

```
secure-pipeline/
├── .github/
│   └── workflows/
│       └── security.yml        # Main CI/CD pipeline with security gates
├── app/
│   ├── index.js                # Sample Node.js application
│   ├── package.json            # Node dependencies
│   └── Dockerfile              # Container definition
├── .trivyignore                # CVE exceptions (documented)
├── sonar-project.properties    # SonarQube config
└── README.md
```

---

## 🚀 How to Run Locally

### Prerequisites
- Docker installed
- Trivy installed (`brew install aquasecurity/trivy/trivy` or see [Trivy docs](https://aquasecurity.github.io/trivy))

### 1. Clone the repo
```bash
git clone https://github.com/sathwikgudimalla/secure-pipeline.git
cd secure-pipeline
```

### 2. Build the Docker image
```bash
docker build -t secure-app ./app
```

### 3. Run Trivy scan manually
```bash
trivy image secure-app
```

### 4. Run the app
```bash
docker run -p 3000:3000 secure-app
```

---

## 📊 Sample Trivy Output

```
secure-app (debian 11.6)
========================
Total: 3 (HIGH: 1, MEDIUM: 2, LOW: 0, CRITICAL: 0)

✅ No CRITICAL vulnerabilities found
⚠️  HIGH: 1 — addressed in .trivyignore with documented justification
```

---

## 🔑 Key DevSecOps Concepts Demonstrated

- **Shift-Left Security** — Security checks happen at code push, not post-deployment
- **Policy-as-Code** — Security gates defined in YAML, versioned with the codebase
- **Supply Chain Security** — Every container image scanned for CVEs before use
- **OWASP Top 10 Awareness** — SAST configured to flag injection, auth, and misconfiguration risks
- **Least Privilege** — Docker image runs as non-root user

---

## 📚 References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Trivy Documentation](https://aquasecurity.github.io/trivy)
- [SonarQube Docs](https://docs.sonarqube.org/)
- [GitHub Actions Security Hardening](https://docs.github.com/en/actions/security-guides)

---

## 👤 Author

**Sathwik Gudimalla**  
Aspiring DevSecOps Engineer  
[LinkedIn](https://linkedin.com/in/sathwikgudimalla) | [GitHub](https://github.com/sathwikgudimalla)
