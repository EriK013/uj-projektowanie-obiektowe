#!/bin/bash

BASE_URL="http://localhost:8000"

echo -e 'Test 1: GET /product'
curl -s $BASE_URL/product

echo -e '\n\nTest 2: GET /product/1'
curl -s $BASE_URL/product/1

echo -e '\n\nTest 3: POST /product'
curl -X POST $BASE_URL/product \
  -H "Content-Type: application/json" \
  -d '{"id":0,"name":"Test","price":0.99}'


echo -e '\n\nTest 4: PUT /product/1'
curl -X PUT $BASE_URL/product/1 \
  -H "Content-Type: application/json" \
  -d '{"id":0,"name":"Test PUT","price":9.99}'

echo -e '\n\nTest 5: DELETE /product/1'
curl -X DELETE $BASE_URL/product/1