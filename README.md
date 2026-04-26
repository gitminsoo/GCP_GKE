# gcp_assign

GCP GKE Autopilot 기반 GitOps CI/CD 과제 프로젝트입니다.

## 구성

- `infra/`: Terraform으로 GCP 인프라 생성
- `manifests/gke-dev/`: ArgoCD가 감시할 Kubernetes Manifest
- `.github/workflows/ci.yml`: GitHub Actions CI, Docker 이미지 빌드 및 Artifact Registry 푸시
- `app/`: 샘플 웹 애플리케이션

## 기본 값과 입력 필요 값

| 항목 | 값 |
|---|---|
| GCP Project | `gcp-assign-494513` |
| Region | `asia-northeast3` |
| GKE Cluster | `ts-gke-cluster` |
| VPC | `ts-vpc` |
| Artifact Registry | `gke-gitops-images` |
| Kubernetes Namespace | `fortune-dev` |

실제 환경별 입력값은 [INPUTS.md](INPUTS.md)에 정리되어 있습니다.

## 실행 순서

Terraform state bucket 생성:

```bash
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

메인 인프라 생성:

```bash
cd infra
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

GitHub Actions secrets 등록:

```bash
terraform output workload_identity_provider
terraform output github_actions_service_account
```

위 출력값을 GitHub repository의 `Settings` -> `Secrets and variables` -> `Actions`에 각각 `GCP_WORKLOAD_IDENTITY_PROVIDER`, `GCP_SERVICE_ACCOUNT` 이름으로 등록합니다.

GKE 연결:

```bash
gcloud container clusters get-credentials ts-gke-cluster --region=asia-northeast3
kubectl create namespace fortune-dev
kubectl create namespace fortune-prod
```

ArgoCD 설치 후 `manifests/gke-dev` 경로를 Application으로 등록하면 됩니다.
