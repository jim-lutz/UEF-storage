START_PROJECT.md
Jim Lutz  Fri Apr  7 17:51:03 2017

Generic instructions to myself for starting a new project. 

1) Make sure R is upto date
  https://cran.r-project.org/bin/linux/ubuntu/
  
2) Make sure R packages are upto date  
    sudo R 
  then 
    update.packages(ask = FALSE, checkBuilt = TRUE)
  
2) Make sure RStudio is upto date
  https://www.rstudio.com/products/rstudio/download/#download
  if not:
  https://askubuntu.com/questions/40779/how-do-i-install-a-deb-file-via-the-command-line
  
3) Make repository on GitHub
  https://github.com/
  
4) Initialize git
  cd /home/jiml/HotWaterResearch/projects/../***/scripts/
  git init
  
5) Make sure local and remote repositories are connected
  git remote -v
  git remote set-url origin https://github.com/jim-lutz/***.git

6) Edit some files then add, commit and push
  git add *.R *.md
  git commit -m "Message about setting up project"
  git push
  
7) connect RStudio and GitHub?
  http://happygitwithr.com/push-pull-github.html
  
  
  



