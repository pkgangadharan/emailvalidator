# Email Validator

A Spring Boot application to validate email addresses using regex and DNS MX record lookup.

## Features

- ✅ Regex validation (RFC-compliant)
- 📡 DNS MX record check
- 🧪 JUnit 5 tests (including CSV and parameterized)
- 🚀 Spring Boot REST API
- 🌐 Swagger/OpenAPI docs
- 🐳 Dockerized deployment
- 💻 Simple frontend UI
- ⚙️ GitHub Actions CI/CD
- ☁️ Render deploy hook ready

## API Usage

### Endpoint

```
GET /api/email/validate?email=someone@example.com
```

### Response

```json
{
  "email": "someone@example.com",
  "validFormat": true,
  "validMX": true,
  "fullyValid": true
}
```

## Run Locally

```bash
mvn spring-boot:run
```

Or using Docker:

```bash
docker build -t email-validator .
docker run -p 8080:8080 email-validator
```

## Test

```bash
mvn test
```

## CI/CD

- On push to `main`, GitHub Actions will:
  - Run tests
  - Build and push Docker image
  - Trigger deployment to Render

## Setup

Configure the following GitHub secrets:

- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `RENDER_DEPLOY_KEY`

---

## License

MIT
