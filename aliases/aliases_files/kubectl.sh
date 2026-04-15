### KUBECTL ALIASES ###########################################################
alias k='kubectl'

alias kaf='kubectl apply -f'
alias kdelf='kubectl delete -f'

alias kapi='kubectl api-resources'

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

# alertmanagerconfig
alias kdamc='kubectl describe alertmanagerconfigs'
alias kdelamc='kubectl delete alertmanagerconfigs'
alias keamc='kubectl edit alertmanagerconfigs'
alias kgamc='kubectl get alertmanagerconfigs'
alias kgamca='kubectl get alertmanagerconfigs --all-namespaces'

# alertmanager
alias kdam='kubectl describe alertmanager'
alias kdelam='kubectl delete alertmanager'
alias keam='kubectl edit alertmanager'
alias kgam='kubectl get alertmanager'
alias kgama='kubectl get alertmanager --all-namespaces'

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

# configmap
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'
alias kecm='kubectl edit configmap'
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'

# cronjob
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'
alias kecj='kubectl edit cronjob'
alias kgcj='kubectl get cronjob'

alias kdelcron='kubectl delete cronjob'
alias kdcron='kubectl describe cronjob'
alias kecron='kubectl edit cronjob'
alias kgcron='kubectl get cronjob'

# customresourcedefinition
alias kdcrd='kubectl describe crd'
alias kdelcrd='kubectl delete crd'
alias kgcrd='kubectl get crd'

# daemonset
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'
alias keds='kubectl edit daemonset'
alias kgds='kubectl get daemonset'
alias krrds='kubectl rollout restart daemonset'
alias krsds='kubectl rollout status daemonset'

# deployment
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ked='kubectl edit deployment'
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias krrd='kubectl rollout restart deployment'
alias krsd='kubectl rollout status deployment'
alias ksd='kubectl scale deployment'

# endpoints
alias kdelep='kubectl delete endpoints'
alias kdep='kubectl describe endpoints'
alias keep='kubectl edit endpoints'
alias kgep='kubectl get endpoints'
alias kgepa='kubectl get endpoints --all-namespaces'

# horizontalpodautoscaler
alias kdelhpa='kubectl delete horizontalpodautoscaler'
alias kdhpa='kubectl describe horizontalpodautoscaler'
alias kehpa='kubectl edit horizontalpodautoscaler'
alias kghpa='kubectl get horizontalpodautoscaler'
alias kghpaa='kubectl get horizontalpodautoscaler --all-namespaces'

# ingress
alias kdeli='kubectl delete ingress'
alias kdi='kubectl describe ingress'
alias kei='kubectl edit ingress'
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'

# ingressclass
alias kdelic='kubectl delete ingressclass'
alias kdi='kubectl describe ingressclass'
alias kei='kubectl edit ingressclass'
alias kgi='kubectl get ingressclass'
alias kgia='kubectl get ingressclass --all-namespaces'

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

# nodepool
alias kdelnp='kubectl delete nodepool'
alias kdnp='kubectl describe nodepool'
alias kenp='kubectl edit nodepool'
alias kgnp='kubectl get nodepool'
alias kgnpall='kubectl get nodepool --all-namespaces'

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

# pod
alias kdelp='kubectl delete pods'
alias kdp='kubectl describe pods'
alias kep='kubectl edit pods'
alias kgp='kubectl get pods -o wide'
alias kgpa='kubectl get pods -o wide --all-namespaces'
kgpyoung() {
  kubectl get pods -o wide \
    --sort-by=.metadata.creationTimestamp \
    | awk 'NR==1 {print; next} {a[NR]=$0} END {for (i=NR; i>=2; i--) print a[i]}'
}
kgpold() {
  kubectl get pods -o wide -A \
    --sort-by=.metadata.creationTimestamp
}
kgpon() {
  kubectl get pods -o wide -A \
    --field-selector spec.nodeName="$1" -o wide
}
kgponyoung() {
  kubectl get pods -o wide -A \
    --field-selector spec.nodeName="$1" \
    --sort-by=.metadata.creationTimestamp \
    | awk 'NR==1 {print; next} {a[NR]=$0} END {for (i=NR; i>=2; i--) print a[i]}'
}
kgponold() {
  kubectl get pods -o wide -A \
    --field-selector spec.nodeName="$1" \
    --sort-by=.metadata.creationTimestamp
}

# poddisruptionbudget
alias kdelpdb='kubectl delete pdb'
alias kdpdb='kubectl describe pdb'
alias kepdb='kubectl edit pdb'
alias kgpdb='kubectl get pdb'
alias kgpdball='kubectl get pdb --all-namespaces'

# priorityclass
alias kdelpc='kubectl delete priorityclass'
alias kdpc='kubectl describe priorityclass'
alias kepc='kubectl edit priorityclass'
alias kgpc='kubectl get priorityclass'
alias kgpca='kubectl get priorityclass --all-namespaces'

# prometheus
alias kdelprom='kubectl delete prometheus'
alias kdprom='kubectl describe prometheus'
alias keprom='kubectl edit prometheus'
alias kgprom='kubectl get prometheus'
alias kgproma='kubectl get prometheus --all-namespaces'

# prometheusrule
alias kdelpromrule='kubectl delete prometheusrule'
alias kdpromrule='kubectl describe prometheusrule'
alias kepromrule='kubectl edit prometheusrule'
alias kgpromrule='kubectl get prometheusrule'
alias kgpromrulea='kubectl get prometheusrule --all-namespaces'

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

# rolebinding
alias kdelrb='kubectl delete rolebinding'
alias kdrb='kubectl describe rolebinding'
alias kerb='kubectl edit rolebinding'
alias kgrb='kubectl get rolebinding'
alias kgrba='kubectl get rolebinding --all-namespaces'

# scrapeconfig
alias kdelsc='kubectl delete scrapeconfig'
alias kdsc='kubectl describe scrapeconfig'
alias kesc='kubectl edit scrapeconfig'
alias kgsc='kubectl get scrapeconfig'
alias kgsca='kubectl get scrapeconfig --all-namespaces'

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

# servicemonitor
alias kdelsm='kubectl delete servicemonitor'
alias kdsm='kubectl describe servicemonitor'
alias kesm='kubectl edit servicemonitor'
alias kgsm='kubectl get servicemonitor'
alias kgsma='kubectl get servicemonitor --all-namespaces'

# statefulset
alias kdelsfs='kubectl delete statefulset'
alias kdsfs='kubectl describe statefulset'
alias kesfs='kubectl edit statefulset'
alias kgsfs='kubectl get statefulset'
alias kgsfsa='kubectl get statefulset --all-namespaces'
alias krrsfs='kubectl rollout restart statefulset'
alias krssfs='kubectl rollout status statefulset'
alias kssfs='kubectl scale statefulset'

alias kdelsts='kubectl delete statefulset'
alias kdsts='kubectl describe statefulset'
alias kets='kubectl edit statefulset'
alias kgsts='kubectl get statefulset'
alias kgstsa='kubectl get statefulset --all-namespaces'
alias krrsts='kubectl rollout restart statefulset'
alias krssts='kubectl rollout status statefulset'
alias ksssts='kubectl scale statefulset'

# storage class
alias kdelsc='kubectl delete storageclass'
alias kdsc='kubectl describe storageclass'
alias kgsc='kubectl get storageclass'

# thanosruler
alias kdeltr='kubectl delete thanosruler'
alias kdtr='kubectl describe thanosruler'
alias ketr='kubectl edit thanosruler'
alias kgtr='kubectl get thanosruler'
alias kgtra='kubectl get thanosruler --all-namespaces'

# users
alias kdelu='kubectl delete user'
alias kdu='kubectl describe user'
alias keu='kubectl edit user'
alias kgu='kubectl get user'
alias kgua='kubectl get user --all-namespaces'

# volume
alias kdelv='kubectl delete v'
alias kdv='kubectl describe v'
alias kev='kubectl edit v'
alias kgv='kubectl get v'
alias kgva='kubectl get v --all-namespaces'

alias kdryrun='kustomize build . | kubectl apply --dry-run=server -f -'
