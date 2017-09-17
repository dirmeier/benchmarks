Server load
===========

Simple server load benchmark for `Gunicorn`, `Node.js` and a `Spring` application.

## Results

This is a simple benchmark for three web-servers I like to use:

* `Node.js` with an `Express` framework,
* `Gunicorn` using a `Flask` framework,
* `Spring`

For benchmarking we use Apache's Benchmark tool (`ab`). The first part benchmarks the response time for 10 *Hello World* `GET` requests. The second part opens an `SQLite` database connection and `GET`s roughly 10000 strings.

For simple `GET` requests `Gunicorn` (mean = 1.6) outperforms `Node.js`(mean  = 4.3) and the `Spring` app (mean = 3.7). However, for requests with more work on the server-side `Spring` seems way faster (mean = 725) compared to `Node.js` (mean = 1236) and `Gunicorn` (mean = 1714).

<div align="center">
<img src="https://github.com/dirmeier/benchmarks/blob/master/server/data/time.png" alt="Drawing" width="75%" />
</div>

## Usage

For `Node.js` usage just install the dependencies using `npm` and then 
test the loading using:

```sh
  node server.js &

  ab -n 10 -v1 127.0.0.1:3000/ > data/time.txt
  ab -n 10 -v1 127.0.0.1:3000/db >> data/time.txt
```
For `Gunicorn` install the requirements using `pip install -r requirements.txt` and run:

```sh
  gunicorn -b 127.0.0.1:4000 server:app &

  ab -n 10 -v1 127.0.0.1:4000/ >> data/time.txt
  ab -n 10 -v1 127.0.0.1:4000/db >> data/time.txt
```

For the `Spring app` build the `jar` using `mvn clean package` first and then run:

```sh
  mvn spring-boot:run

  ab -n 10 -v1 127.0.0.1:8080/ >> data/time.txt
  ab -n 10 -v1 127.0.0.1:8080/db >> data/time.txt
```
