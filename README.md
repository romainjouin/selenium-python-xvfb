####Useful Docker container image

Forked from: https://goo.gl/Fu723f khozzy/selenium-python-chrome

#### BUILD IMAGE:

You can choose between:

##### 1) Build from Dockerfile:

` docker build -t selenium . ` (in the same path of your Dockerfile)

##### 2) Pull it from docker hub:
` docker pull pimuzzo/selenium_python_xvfb `

#### RUN CONTAINER:

You can choose between:

##### 1) Joining inside
` docker run --name selenium -ti --net=host pimuzzo/selenium_python_xvfb bash`

##### 2) Using from outside
` docker run -ti -v /your_local_dir:/home/something selenium python /something/your_file.py `

Optional:
- You can specify the browser:
` -e BROWSER=chrome `

#### EXAMPLE OF CODE WITH SELENIUM:
```
#!/usr/bin/env python

from pyvirtualdisplay import Display
from selenium import webdriver

display = Display(visible=0, size=(800, 600))
display.start()

# now Firefox will run in a virtual display. 
# you will not see the browser.
browser = webdriver.Firefox()
browser.get('http://www.google.com')
print browser.title
browser.quit()

display.stop()
```
source: http://goo.gl/cmLS9Z
