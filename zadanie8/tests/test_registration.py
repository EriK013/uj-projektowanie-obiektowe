import http.server
import os
import socketserver
import threading

import pytest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

PORT = 8000
APP_DIR = os.path.join(os.path.dirname(__file__), "..")


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=APP_DIR, **kwargs)


@pytest.fixture(scope="session", autouse=True)
def server():
    httpd = socketserver.TCPServer(("", PORT), Handler)
    threading.Thread(target=httpd.serve_forever, daemon=True).start()
    yield
    httpd.shutdown()


@pytest.fixture
def driver():
    options = Options()
    options.add_argument("--headless=new")
    options.add_argument("--window-size=1280,1024")
    driver = webdriver.Chrome(options=options)
    driver.get(f"http://localhost:{PORT}/index.html")
    WebDriverWait(driver, 60).until(
        EC.presence_of_element_located((By.ID, "submit"))
    )
    yield driver
    driver.quit()


def fill(driver, field, value):
    el = driver.find_element(By.ID, field)
    el.clear()
    el.send_keys(value)


def submit(driver):
    driver.find_element(By.ID, "submit").click()


def error(driver, field):
    el = WebDriverWait(driver, 20).until(
        EC.visibility_of_element_located(
            (By.CSS_SELECTOR, f'[data-testid="error-{field}"]')
        )
    )
    return el.text


def success_shown(driver):
    return len(driver.find_elements(By.CSS_SELECTOR, '[data-testid="register-success"]')) > 0


def test_empty_form_shows_required_errors(driver):
    submit(driver)
    assert error(driver, "username") == "Username is required"
    assert error(driver, "email") == "Email is required"
    assert error(driver, "password") == "Password is required"
    assert not success_shown(driver)


def test_invalid_email_format(driver):
    fill(driver, "username", "alice")
    fill(driver, "email", "abc")
    fill(driver, "password", "secret123")
    submit(driver)
    assert error(driver, "email") == "Invalid email format"
    assert not success_shown(driver)


def test_valid_data_registers(driver):
    fill(driver, "username", "alice")
    fill(driver, "email", "alice@example.com")
    fill(driver, "password", "secret123")
    submit(driver)
    WebDriverWait(driver, 20).until(
        EC.visibility_of_element_located(
            (By.CSS_SELECTOR, '[data-testid="register-success"]')
        )
    )
    assert success_shown(driver)
