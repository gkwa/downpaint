#!/usr/bin/env bash

set -e
set -x
set -u

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
dir=$(mktemp -d $script_dir/test.XXXXX)/faris
mkdir -p $dir
cd $dir

rm -rf stat


echo $dir >stat

rye init

rm -rf src

rye pin 3.12

rye add molecule

rye sync --quiet

set +x
. .venv/bin/activate
set -x

python --version

ansible --version
molecule --version
mkdir -p $dir/collections/ansible_collections
cd $dir/collections/ansible_collections

# create new collection bar in namespace foo
ansible-galaxy collection init foo.bar 


cd $dir/collections/ansible_collections/foo/bar/roles
ansible-galaxy role init my_role
cat my_role/tasks/main.yml
cat >my_role/tasks/main.yml<<'EOF'
---
- name: Task is running from within the role
  ansible.builtin.debug:
    msg: "This is a task from my_role."
EOF


mkdir -p $dir/collections/ansible_collections/foo/bar/playbooks
cd $dir/collections/ansible_collections/foo/bar/playbooks

cat >my_playbook.yml<<'EOF'
---
- name: Test new role from within this playbook
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Testing role
      ansible.builtin.include_role:
        name: foo.bar.my_role
        tasks_from: main.yml
EOF

mkdir -p $dir/collections/ansible_collections/foo/bar/extensions
cd $dir/collections/ansible_collections/foo/bar/extensions

# https://ansible.readthedocs.io/projects/molecule/getting-started/
# Adding Molecule to the Collection

molecule init scenario

# https://ansible.readthedocs.io/projects/molecule/getting-started/#run-a-full-test-sequence
# molecule test --destroy=never
molecule test


cd $dir/collections/ansible_collections/foo/bar/extensions
cat >molecule/default/converge.yml <<EOF
---
- name: Include a role from a collection
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Testing role
      ansible.builtin.include_role:
        name: foo.bar.my_role
        tasks_from: main.yml
EOF

cat molecule/default/converge.yml

cd $dir/collections/ansible_collections/foo/bar/extensions
molecule converge
molecule test


cat >molecule/default/converge.yml <<EOF
---
- name: Include a playbook from a collection
  ansible.builtin.import_playbook: foo.bar.my_playbook
EOF

cat molecule/default/converge.yml


cd $dir/collections/ansible_collections/foo/bar/extensions
molecule converge
molecule test

cd $dir
tree --charset=ascii $dir | tee tree.txt
rg --files $dir | tee list.txt
