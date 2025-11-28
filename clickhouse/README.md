# Ansible Role: ClickHouse

## Описание

Развертывание Clickhouse

## Требования

- Rocky Linux 9
- Ansible 2.1+

## Переменные

```yaml
clickhouse_db_name: logs
clickhouse_db_table: vector_logs
```

## Использование

```yaml
- name: "Deploy ClickHouse"
  hosts: clickhouse
  become: true
  vars:
    clickhouse_database: "logs"
    clickhouse_table: "vector_logs"
  roles:
    - clickhouse
```
