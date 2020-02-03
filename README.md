# Test task solution

## Prerequisites

Please ensure that `docker` and `docker-compose` are available in your system.


## Two-click launch

```bash
bin/start_cluster.sh
bin/load_data.sh
```

## Examples

Get result as defined in test task description

1. Using SQL query 
```bash
curl --request GET \
  --url http://0.0.0.0:5000/by-query
```

2. Using SQLAlchemy and ORM
```bash
curl --request GET \
  --url http://0.0.0.0:5000/by-orm
```

## Response

```json
{
  "Action":"Please click the link below",
  "figure":"http://localhost:5000/files/fig-b175377c-711e-434d-9dbf-89f234b8ba4d.png"
}
```
```
