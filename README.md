# hello-world

A tiny static site used to validate the k3s CI/CD pipeline:

**Jenkins builds the image (Kaniko) → pushes to the in-cluster registry
(`192.168.1.245:5001`) → ArgoCD deploys it to the cluster.**

- `index.html` — the page
- `Dockerfile` — builds it into an nginx image
- `Jenkinsfile` — the pipeline (Kaniko build + push)

This is throwaway scaffolding to prove the loop works before wiring up the real
portfolio site.
