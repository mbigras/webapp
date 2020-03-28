# webapp

> Flask app served with Gunicorn

## Tools

* Flask web framework
* Gunicorn application server
* Poetry dependency management
* Docker container manager
* make build automation

## Setup

```
git clone https://github.com/mbigras/webapp
cd webapp
make build
make run
curl localhost:5000/
```

## Deploy to Cloud Run

```
export TF_VAR_project=<YOUR PROJECT>
make deps
make cloudbuild
make init
make plan
make apply
make output
make list
export URL=<YOUR URL>
curl $URL/
make destroy
make apply
```
