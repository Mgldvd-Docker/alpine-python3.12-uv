import requests


def main() -> None:
  response = requests.get("https://httpbin.org/json", timeout=5)
  print(response.json()["slideshow"]["title"])


if __name__ == "__main__":
  main()
