# Start Jenkins

1.  cd ~/webpage_ws
    bash start_jenkins.sh

2.  cat ~/webpage_ws/jenkins__pid__url.txt
3.  copy Jenkins URL to browser

4.  Log into Jenkins
    Username: tester
    Password: tester123

    Now you are inside Jenkins!

# Push code to ros1_ci repository

1.  cd ~/catkin_ws/src/ros1_ci
2.  git commit -m"Test #n" where n = number of test. You can do a modification before commiting
3.  git push

So see a new build inside Jenkins!