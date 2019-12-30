#!/bin/sh
echo "*****************Build Application Deployment Start Output*****************"
pwd
echo $4
sudo wget https://$3.s3.ap-south-1.amazonaws.com/code_repo/user.zip
sudo wget https://$3.s3.ap-south-1.amazonaws.com/code_repo/dashboard.zip
sudo cp /var/lib/jenkins/private.pem $4
sudo cp /var/lib/jenkins/config.php $4


moving_code_remote()
{
  PrivareIP=$1
  CodeZip=$2
  
  echo "Private IP Address: $PrivareIP"
  echo "Code Folder: $CodeZip"
  
  sudo scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $4/private.pem $4/$CodeZip ubuntu@$PrivareIP:~
  
  sudo ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $4/private.pem ubuntu@$PrivareIP "sudo cp /home/ubuntu/$CodeZip /var/www/html/"
  
  sudo ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $4/private.pem ubuntu@$PrivareIP "cd /var/www/html/; sudo unzip -o $CodeZip"
  
  sudo scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $4/private.pem $4/config.php ubuntu@$PrivareIP:~
  
  sudo ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $4/private.pem ubuntu@$PrivareIP "sudo cp /home/ubuntu/config.php /var/www/html/user/"

}

moving_code_remote $1 user.zip
moving_code_remote $1 dashboard.zip
moving_code_remote $2 user.zip
moving_code_remote $2 dashboard.zip

echo "*****************Build Application Deployment End Output*****************"