from python:3.7

RUN apt update && apt install build-essential libgtk-3-dev -y
RUN  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./google-chrome-stable_current_amd64.deb -y
RUN wget https://chromedriver.storage.googleapis.com/100.0.4896.60/chromedriver_linux64.zip && unzip chromedriver_linux64.zip && cp chromedriver /bin/chromedriver && chmod +x /bin/chromedriver
COPY Requirements.txt Requirements.txt
RUN pip install https://extras.wxpython.org/wxPython4/extras/linux/gtk3/debian-10/wxPython-4.1.1-cp37-cp37m-linux_x86_64.whl
RUN pip3 install -r Requirements.txt
RUN python -m compileall Library\.
RUN pip3 install robotframework-pabot
COPY . .
# RUN pabot --testlevelsplit --argumentfile1 chrome.txt -d Reports KeywordTestcases/Web/Workspace.robot
CMD robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir Reports --variable URL:https://beta.leonardo247.com/ --variable NORMAL_USER_NAME:kusuma.kasani@qualizeal.com --variable NORMAL_PASSWORD:Kusuma@123 --variable HEADLESS:True KeywordTestcases/Web/*.robot
