# Required Inputs

아래 값을 채워주면 Terraform, GitHub Actions, ArgoCD 설정을 실제 환경에 맞게 확정할 수 있습니다.

## Terraform

| 항목 | 설명 | 값 |
|---|---|---|
| `project_id` | GCP 프로젝트 ID | gcp-assign-494513 |
| `region` | GCP 리전. 기본값은 `asia-northeast3` | asia-northeast3 |
| `zone_a` | 첫 번째 존. 기본값은 `asia-northeast3-a` | asia-northeast3-a |
| `zone_c` | 두 번째 존. 기본값은 `asia-northeast3-c` | asia-northeast3-c |
| `github_owner` | GitHub 사용자명 또는 조직명 | gitminsoo |
| `github_repo` | GitHub 저장소 이름 | GCP_GKE |

## Terraform Backend

현재 [provider.tf](infra/provider.tf)에 GCS backend가 설정되어 있습니다.

| 항목 | 설명 | 값 |
|---|---|---|
| Terraform state bucket | Terraform state를 저장할 GCS bucket 이름 | minsoogke0426 |
| Terraform state prefix | bucket 안에서 state를 저장할 prefix. 현재 예시는 `gke/state` | gke/state |

GCS backend bucket은 메인 Terraform 코드가 자기 자신의 backend로 바로 만들 수 없습니다. 대신 [infra/bootstrap](infra/bootstrap) 코드로 먼저 생성합니다. 이 bucket에는 `force_destroy = true`가 설정되어 있어 Terraform destroy 시 bucket 안의 object까지 함께 삭제할 수 있습니다.

실행 순서:

```bash
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars
# terraform.tfvars에서 project_id 입력
terraform init
terraform apply

cd ..
terraform init
terraform apply
```

## GitHub Actions Secrets

Terraform apply 후 output 값을 GitHub repository secrets에 등록해야 합니다. 이 값들은 지금 직접 만드는 값이 아니라, 메인 Terraform apply가 끝난 뒤 `terraform output` 명령으로 확인해서 GitHub에 복사하는 값입니다.

| GitHub Secret 이름 | 넣어야 하는 값 |
|---|---|
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Terraform output `workload_identity_provider` |
| `GCP_SERVICE_ACCOUNT` | Terraform output `github_actions_service_account` |

확인 명령:

```bash
cd infra
terraform output workload_identity_provider
terraform output github_actions_service_account
```

GitHub 등록 위치:

```text
GitHub repository -> Settings -> Secrets and variables -> Actions -> New repository secret
```

## ArgoCD

| 항목 | 설명 | 값 |
|---|---|---|
| Git repository URL | ArgoCD가 감시할 GitHub 저장소 URL | https://github.com/gitminsoo/GCP_GKE.git |
| Manifest path | ArgoCD Application source path | manifests/gke-dev |
| Target branch | 배포 기준 브랜치. 현재 값은 `main` | main |

## 확인 후 수정할 파일

값을 정한 뒤 아래 파일들을 실제 값으로 맞추면 됩니다.

- [infra/terraform.tfvars](infra/terraform.tfvars)
- [infra/provider.tf](infra/provider.tf)
- [manifests/argocd-app.yaml](manifests/argocd-app.yaml)
- [.github/workflows/ci.yml](.github/workflows/ci.yml)
