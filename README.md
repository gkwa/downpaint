# downpaint

## Purpose

Learn the canonical way to organize ansible collections by following the molecule getting started guide from https://ansible.readthedocs.io/projects/molecule/getting-started/.

## Motivation

I'd like to use ansible to setup elastic and elastic certs from https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-stack-security.html.

## layout

```log
+ cd /tmp/test.LDhTr/faris
+ tree --charset=ascii /tmp/test.LDhTr/faris
+ tee tree.txt
/tmp/test.LDhTr/faris
|-- README.md
|-- collections
|   `-- ansible_collections
|       `-- foo
|           `-- bar
|               |-- README.md
|               |-- docs
|               |-- extensions
|               |   `-- molecule
|               |       `-- default
|               |           |-- converge.yml
|               |           |-- create.yml
|               |           |-- destroy.yml
|               |           `-- molecule.yml
|               |-- galaxy.yml
|               |-- meta
|               |   `-- runtime.yml
|               |-- playbooks
|               |   `-- my_playbook.yml
|               |-- plugins
|               |   `-- README.md
|               `-- roles
|                   `-- my_role
|                       |-- README.md
|                       |-- defaults
|                       |   `-- main.yml
|                       |-- files
|                       |-- handlers
|                       |   `-- main.yml
|                       |-- meta
|                       |   `-- main.yml
|                       |-- tasks
|                       |   `-- main.yml
|                       |-- templates
|                       |-- tests
|                       |   |-- inventory
|                       |   `-- test.yml
|                       `-- vars
|                           `-- main.yml
|-- pyproject.toml
|-- requirements-dev.lock
`-- requirements.lock

22 directories, 21 files
+ rg --files /tmp/test.LDhTr/faris
+ tee list.txt
/tmp/test.LDhTr/faris/requirements.lock
/tmp/test.LDhTr/faris/tree.txt
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/galaxy.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/README.md
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/extensions/molecule/default/destroy.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/extensions/molecule/default/create.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/extensions/molecule/default/converge.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/extensions/molecule/default/molecule.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/playbooks/my_playbook.yml
/tmp/test.LDhTr/faris/README.md
/tmp/test.LDhTr/faris/pyproject.toml
/tmp/test.LDhTr/faris/list.txt
/tmp/test.LDhTr/faris/requirements-dev.lock
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/plugins/README.md
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/meta/runtime.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/handlers/main.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/meta/main.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/defaults/main.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/README.md
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/tests/inventory
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/tests/test.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/vars/main.yml
/tmp/test.LDhTr/faris/collections/ansible_collections/foo/bar/roles/my_role/tasks/main.yml
[mtm@taylors-MacBook-Pro-2:downpaint(master)]$
```
