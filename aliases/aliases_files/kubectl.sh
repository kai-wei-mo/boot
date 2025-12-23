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
alias keit='kubectl exec -it'

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

# clusterrole
alias kdcr='kubectl describe clusterrole'
alias kdelcr='kubectl delete clusterrole'
alias kecr='kubectl edit clusterrole'
alias kgcr='kubectl get clusterrole'

# clusterrolebinding
alias kdelcrb='kubectl delete clusterrolebinding'
alias kdcrb='kubectl describe clusterrolebinding'
alias kecrb='kubectl edit clusterrolebinding'
alias kgcrb='kubectl get clusterrolebinding'

# customresourcedefinition
alias kdcrd='kubectl describe crd'
alias kdelcrd='kubectl delete crd'
alias kgcrd='kubectl get crd'

# cronjob
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'
alias kecj='kubectl edit cronjob'
alias kgcj='kubectl get cronjob'

alias kdelcron='kubectl delete cronjob'
alias kdcron='kubectl describe cronjob'
alias kecron='kubectl edit cronjob'
alias kgcron='kubectl get cronjob'

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

# job
alias kdj='kubectl describe job'
alias kdelj='kubectl delete job'
alias kej='kubectl edit job'
alias kgj='kubectl get job'
alias kgja='kubectl get job --all-namespaces'

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

alias kdelnode='kubectl delete node'
alias kdnode='kubectl describe node'
alias kenode='kubectl edit node'
alias kgnode='kubectl get nodes'

# pod
alias kdelp='kubectl delete pods'
alias kdp='kubectl describe pods'
alias kep='kubectl edit pods'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'

# poddisruptionbudget
alias kdelpdb='kubectl delete pdb'
alias kdpdb='kubectl describe pdb'
alias kepdb='kubectl edit pdb'
alias kgpdb='kubectl get pdb'
alias kgpdball='kubectl get pdb --all-namespaces'

# persistentvolume
alias kdelpv='kubectl delete pv'
alias kdpv='kubectl describe pv'
alias kepv='kubectl edit pv'
alias kgpv='kubectl get pv'
alias kgpva='kubectl get pv --all-namespaces'

# persistentvolumeclaim
alias kdelpvc='kubectl delete pvc'
alias kdpvc='kubectl describe pvc'
alias kepvc='kubectl edit pvc'
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'

# replicaset
alias kdelrs='kubectl delete rs'
alias kdrs='kubectl describe rs'
alias kers='kubectl edit rs'
alias kgrs='kubectl get rs'
alias kgrsa='kubectl get rs --all-namespaces'

# role
alias kdelr='kubectl delete role'
alias kdr='kubectl describe role'
alias ker='kubectl edit role'
alias kgr='kubectl get role'
alias kgra='kubectl get role --all-namespaces'

alias kdelrole='kubectl delete role'
alias kdrole='kubectl describe role'
alias kerole='kubectl edit role'
alias kgrrole='kubectl get role'
alias kgrroleall='kubectl get role --all-namespaces'

# sealedsecret
alias kdelss='kubectl delete sealedsecret'
alias kdss='kubectl describe sealedsecret'
alias kess='kubectl edit sealedsecret'
alias kgss='kubectl get sealedsecret'
alias kgssa='kubectl get sealedsecret --all-namespaces'

# secret
alias kdelsec='kubectl delete secret'
alias kdsec='kubectl describe secret'
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
kgsecp() {
    kubectl get secret "$1" -o jsonpath="./_secret.txt" -n "${3:-default}" | base64 -d
}

# service
alias kdels='kubectl delete svc'
alias kds='kubectl describe svc'
alias kes='kubectl edit svc'
alias kgs='kubectl get svc'
alias kgsall='kubectl get svc --all-namespaces'

# service account
alias kdelsa='kubectl delete sa'
alias kdsa='kubectl describe sa'
alias kesa='kubectl edit sa'
alias kgsa='kubectl get sa'
alias kgsaall='kubectl get sa --all-namespaces'

# statefulset
alias kdelsfs='kubectl delete statefulset'
alias kdsfs='kubectl describe statefulset'
alias kesfs='kubectl edit statefulset'
alias kgsfs='kubectl get statefulset'
alias kgssfa='kubectl get statefulset --all-namespaces'
alias krssfs='kubectl rollout status statefulset'
alias kssfs='kubectl scale statefulset'

# storage class
alias kdelsc='kubectl delete sc'
alias kdsc='kubectl describe sc'
alias kgsc='kubectl get sc'

# volume
alias kdelv='kubectl delete v'
alias kdv='kubectl describe v'
alias kev='kubectl edit v'
alias kgv='kubectl get v'
alias kgva='kubectl get v --all-namespaces'

alias kdryrun='kustomize build . | kubectl apply --dry-run=server -f -'
