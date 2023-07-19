### KUBECTL ALIASES ###########################################################
alias k='kubectl'

alias kaf='kubectl apply -f'
alias kdelf='kubectl delete -f'

# config
alias kccc='kubectl config current-context'
alias kcdelc='kubectl config delete-context'
alias kcgc='kubectl config get-contexts'
alias kcn='kubectl config set-context --current --namespace'
alias kcsc='kubectl config set-context'
alias kcuc='kubectl config use-context'

# logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# misc
alias kca='_kca(){ kubectl "$@" --all-namespaces; unset -f _kca; }; _kca'
alias kcp='kubectl cp'
alias kdel='kubectl delete'
alias keti='kubectl exec -ti'
alias kgrs='kubectl get rs'

alias kpf='kubectl port-forward'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'


## RESOURCE-SPECIFIC ALIASES

# configmap
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'
alias kecm='kubectl edit configmap'
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'

# crd
alias kdcrd='kubectl describe crd'
alias kdelcrd='kubectl delete crd'
alias kgcrd='kubectl get crd'

# cronjob
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'
alias kecj='kubectl edit cronjob'
alias kgcj='kubectl get cronjob'

# daemonset
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'
alias keds='kubectl edit daemonset'
alias kgds='kubectl get daemonset'

# deployment
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ked='kubectl edit deployment'
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias krsd='kubectl rollout status deployment'
alias ksd='kubectl scale deployment'

# ingress
alias kdeli='kubectl delete ingress'
alias kdi='kubectl describe ingress'
alias kei='kubectl edit ingress'
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'

# namespace
alias kdelns='kubectl delete namespace'
alias kdns='kubectl describe namespace'
alias kens='kubectl edit namespace'
alias kgns='kubectl get namespaces'

# node
alias kdelno='kubectl delete node'
alias kdno='kubectl describe node'
alias keno='kubectl edit node'
alias kgno='kubectl get nodes'

# pod
alias kdelp='kubectl delete pods'
alias kdp='kubectl describe pods'
alias kep='kubectl edit pods'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'

# pvc
alias kdelpvc='kubectl delete pvc'
alias kdpvc='kubectl describe pvc'
alias kepvc='kubectl edit pvc'
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'

# service (svc)
alias kdels='kubectl delete svc'
alias kds='kubectl describe svc'
alias kes='kubectl edit svc'
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'

# secret
alias kdelsec='kubectl delete secret'
alias kdsec='kubectl describe secret'
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
kgsecp() {
    kubectl get secret "$1" -o jsonpath="./_secret.txt" -n "${3:-default}" | base64 -d
}

# service account (sa)
alias kdelsa='kubectl delete sa'
alias kdsa='kubectl describe sa'

# statefulset
alias kdelss='kubectl delete statefulset'
alias kdss='kubectl describe statefulset'
alias kess='kubectl edit statefulset'
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias krsss='kubectl rollout status statefulset'
alias ksss='kubectl scale statefulset'

# storage class
alias kdelsc='kubectl delete sc'
alias kdsc='kubectl describe sc'
alias kgsc='kubectl get sc'
