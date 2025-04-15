from fastapi.testclient import TestClient

from nb2prod_api_service.main import app

client = TestClient(app)


def test_predict():
    response = client.post("/predict", json={"data": [1, 2, 3]})
    assert response.status_code == 200
    assert "prediction" in response.json()
