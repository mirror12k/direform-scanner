# scanning
```sh
docker run -v "$PWD/data:/src" --rm returntocorp/semgrep semgrep scan --config auto
# scanning with direform
docker run -v "$PWD/data:/src" -v "$PWD/rules:/rules" --rm returntocorp/semgrep semgrep scan --config /rules/direform-rules.yml
# verifying test cases
docker run -v "$PWD/data:/src" -v "$PWD/rules:/rules" --rm returntocorp/semgrep semgrep --test /rules/check.tf --config /rules/direform-rules.yml
# checking community rules on the test example
docker run -v "$PWD/data:/src" -v "$PWD/rules:/rules" --rm returntocorp/semgrep semgrep --config auto /rules/check.tf
```
