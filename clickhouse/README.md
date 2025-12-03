# Ansible Role: ClickHouse

## Описание

Развертывание Clickhouse

## Требования

- Rocky Linux 9
- Ansible 2.18

## Зависимости

- community.general
- community.clickhouse

```bash
ansible-galaxy collection install -r requirements.yml
```

## Переменные

```yaml
clickhouse_database: database
clickhouse_table: table

rocky_repo: https://packages.clickhouse.com/rpm/stable/
rocky_repo_key: https://packages.clickhouse.com/rpm/stable/repodata/repomd.xml.key

ubuntu_repo: https://packages.clickhouse.com/deb
ubuntu_repo_key: https://packages.clickhouse.com/rpm/lts/repodata/repomd.xml.key
```

## Использование

```yaml
- name: clickhouse
  hosts: all
  become: true
  become_user: root
  vars:
    clickhouse_database: "test_db"
    clickhouse_table: "test_table"
  roles:
    - clickhouse
```
