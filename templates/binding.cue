package templates

import (
	rbacv1 "k8s.io/api/rbac/v1"
)

#ClusterRoleBinding: rbacv1.#ClusterRoleBinding & {
	kind:       "ClusterRoleBinding"
	apiVersion: "rbac.authorization.k8s.io/v1"
	#config: #Config

	metadata: {
		name: "k8s-vault-addon-\(#config.metadata.name)"
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind: "ClusterRole"
		name: #config.metadata.name
	}
	subjects: [{
		kind: "ServiceAccount"
	  name: #config.vault.serviceAccount.name
	  namespace: #config.vault.serviceAccount.namespace
	}]
}
