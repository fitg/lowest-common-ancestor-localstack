# Lowest common ancestor

## About this project

Fun playground that is to be used to test out various scenarios in python.

## Installing dependencies

You are given two nodes in a symmetrical binary tree.<br />
The tree is numbered incrementally from left to right.<br />
Each node can only have one parent and two children.<br />
Without creating a tree structure in memory<br />
try to find the lowest common ancestor.<br />
https://en.wikipedia.org/wiki/Lowest_common_ancestor.<br />
Nodes start from 1.<br />
<br />
Examples:<br />
6, 5 -> lowest common ancestor: 1<br />
18, 5 -> lowest common ancestor: 2<br />
Conditions<br />
1 >= node1 <= 1000000<br />
1 >= node2 <= 1000000<br />
the program takes 2 ints as an input and returns 1 int<br />


This repo will attempt to run this method as a lambda in localstack.
<br />

```sh
# install python version
pyenv install 3.9.6
# set/activate local python version
pyenv local 3.9.6
# install poetry
pip install poetry
# install poetry settings using pyproject.toml file
poetry install
# install terraform
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

## Format checks

make lint - execute flake8

make black - run black and format files

## Testing

```sh
make unit-test
```

## Running

```sh
make all
```

After completing project installation, you can also run it with:

```sh
poetry run execute <node1 id> <node2 id>
```

For help use:

```sh
poetry run execute --help
```
