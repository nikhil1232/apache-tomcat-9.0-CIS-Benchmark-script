#!/bin/bash

a="Apache_Tomcat_9.0.txt"

flag=0

while [ $flag -ne 1 ]
do
echo -e "Enter the APP name located in the following directory/format: \$CATALINA_HOME/webapps/<App_name>/WEB-INF/web.xml\n"
read app
y=$(ls -al $loc 2>&1)
var=$(echo $y | grep "No such file")
if [ -z "$var" ];
then
  break
fi
echo -e "\nThe Configuration file doesn't exist.Type again\n"
done

while [ $flag -ne 1 ]
do
echo -e "Enter the APP Engine located in the following directory/format: \$CATALINA_BASE/conf/<enginename>/<hostname>/manager.xml "
read enginename
y2=$(ls -al $enginename 2>&1)
var2=$(echo $y2 | grep "No such file")
if [ -z "$var2" ];
then
  break
fi
echo -e "\nThe file/folder doesn't exist.Type again\n"
done


while [ $flag -ne 1 ]
do
echo -e "Enter the Host name located in the following directory/format: \$CATALINA_BASE/conf/<enginename>/<hostname>/manager.xml "
read hostname
y3=$(ls -al $hostname 2>&1)
var3=$(echo $y3 | grep "No such file")
if [ -z "$var3" ];
then
  break
fi
echo -e "\nThe file/folder doesn't exist.Type again\n"
done





echo -e "\n ===========================================================================================\n" >> $a
echo -e "\n|                       Apache Tomcat 9.0 CIS Benchmark v1.0.0 Script                       |\n" >> $a
echo -e "\n ===========================================================================================\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n1.1 Remove extraneous files and directories\n" >> $a 
ls -l $CATALINA_HOME/webapps/examples \
$CATALINA_HOME/webapps/docs \ 
$CATALINA_HOME/webapps/ROOT \
$CATALINA_HOME/webapps/host-manager \
$CATALINA_HOME/webapps/manage >> $a 

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n1.2Disable Unused Connectors\n" >> $a
grep “Connector” $CATALINA_HOME/conf/server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.1 Alter the Advertised server.info String\n" >> $a
cd $CATALINA_HOME/lib
jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
grep server.info org/apache/catalina/util/ServerInfo.properties >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.2 Alter the Advertised server.number String \n" >> $a
cd $CATALINA_HOME/lib
jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
grep server.number org/apache/catalina/util/ServerInfo.properties  >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "2.3 Alter the Advertised server.built Date\n" >> $a
cd $CATALINA_HOME/lib
jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
grep server.built org/apache/catalina/util/ServerInfo.properties >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.4 Disable X-Powered-By HTTP Header and Rename the Server Value for all Connectors\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.5 Disable client facing Stack Traces\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.6 Turn off TRACE\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.6 Turn off TRACE\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n2.7 Ensure Sever Header is Modified To Prevent Information Disclosure\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n3.1 Set a nondeterministic Shutdown command value \n" >> $a
cd $CATALINA_HOME/conf
grep 'shutdown[[:space:]]*=[[:space:]]*"SHUTDOWN"' server.xml</span> >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n3.2 Disable the Shutdown port \n" >> $a
cd $CATALINA_HOME/conf/
grep '<Server[[:space:]]\+[^>]*port[[:space:]]*=[[:space:]]*"-1"' server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.1 Restrict access to $CATALINA_HOME\n" >> $a
cd $CATALINA_HOME
find . -follow -maxdepth 0 \( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.2 Restrict access to $CATALINA_BASE\n" >> $a
cd $CATALINA_BASE
find . -follow -maxdepth 0 \( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.3 Restrict access to Tomcat configuration directory\n" >> $a
cd $CATALINA_HOME/conf
find . -maxdepth 0 \( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.4 Restrict access to Tomcat logs directory\n" >> $a
cd $CATALINA_HOME
find logs -follow -maxdepth 0 \( -perm /o+rwx -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.5 Restrict access to Tomcat temp directory \n" >> $a
cd $CATALINA_HOME
find temp -follow -maxdepth 0 \( -perm /o+rwx -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.6 Restrict access to Tomcat binaries directory \n" >> $a
cd $CATALINA_HOME
find bin -follow -maxdepth 0 \( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.7 Restrict access to Tomcat web application directory \n" >> $a
cd $CATALINA_HOME
find webapps -follow -maxdepth 0 \( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.8 Restrict access to Tomcat catalina.properties \n" >> $a
cd $CATALINA_HOME/conf/
find catalina.properties -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.9 Restrict access to Tomcat catalina.policy\n" >> $a
cd $CATALINA_HOME/conf/
find catalina.policy -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.10 Restrict access to Tomcat context.xml\n" >> $a
cd $CATALINA_HOME/conf
find context.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.11 Restrict access to Tomcat logging.properties\n" >> $a
cd $CATALINA_HOME/conf/
find logging.properties -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.12 Restrict access to Tomcat server.xml \n" >> $a
cd $CATALINA_HOME/conf/
find server.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.13 Restrict access to Tomcat tomcat-users.xml\n" >> $a
cd $CATALINA_HOME/conf/
find tomcat-users.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.14 Restrict access to Tomcat web.xml\n" >> $a
cd $CATALINA_HOME/conf/
find web.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+wx -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n4.15 Restrict access to jaspic-providers.xml\n" >> $a
cd $CATALINA_HOME/conf/
find jaspic-providers.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o ! -user tomcat_admin -o ! -group tomcat \) -ls >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n5.1 Use secure Realms\n" >> $a
grep "Realm className" $CATALINA_HOME/conf/server.xml | grep MemoryRealm >> $a
grep "Realm className" $CATALINA_HOME/conf/server.xml | grep JDBCRealm >> $a
grep "Realm className" $CATALINA_HOME/conf/server.xml | grep UserDatabaseRealm >> $a
grep "Realm className" $CATALINA_HOME/conf/server.xml | grep JAASReal >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n5.2 Use LockOut Realms\n" >> $a
grep "LockOutRealm" $CATALINA_HOME/conf/server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n6 Connector Security\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a

echo -e "\n7.1 Application specific logging\n" >> $a
FILE=$CATALINA_BASE/webapps/$app/WEBINF/classes/logging.properties
if [ -f "$FILE" ]; then
    echo "$FILE exist" >> $a
else 
    echo "$FILE does not exist" >> $a
fi


echo -e "\n==========================================================================================\n" >> $a
echo -e "\n7.2 Specify file handler in logging.properties files\n" >> $a
if [ -f "$FILE" ]; then
    grep handlers \
    $CATALINA_BASE/webapps/$app/WEB-INF/classes/logging.properties >> $a
else 
    grep handlers $CATALINA_BASE/conf/logging.properties >> $a
fi

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n7.3 Ensure className is set correctly in context.xml\n" >> $a
grep org.apache.catalina.valves.AccessLogValve $CATALINA_BASE/webapps/$app/META-INF/context.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n7.4 Ensure directory in context.xml is a secure location\n" >> $a
var=$(grep directory $CATALINA_BASE\webapps\$app\METAINF\context.xml | cut -d "=" -f 2 | tr -d '"')
if [ ! -z $var ]
then
      
        ls -ld $var >> $a
fi

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n7.5 Ensure pattern in context.xml is correct\n" >> $a
grep pattern $CATALINA_BASE/webapps/$app/META-INF/context.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n7.6 Ensure directory in logging.properties is a secure location\n" >> $a
var2=$(grep directory $File | cut -d "=" -f 2 | tr -d '"')
if [ ! -z $var2 ]
then
      
        ls -ld $var2 >> $a
fi
else 
    	var3=$(grep directory $CATALINA_BASE/conf/logging.properties| cut -d "=" -f 2 | tr -d '"')
    	ls -ld $var3 >> $a
fi

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n8.1 Restrict runtime access to sensitive packages\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n9.1 Starting Tomcat with Security Manager\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n9.2 Disabling auto deployment of applications\n" >> $a
grep "autoDeploy" $CATALINA_HOME/conf/server.xml >> $a


echo -e "\n==========================================================================================\n" >> $a
echo -e "\n9.3 Disable deploy on startup of applications\n" >> $a
grep "deployOnStartup" $CATALINA_HOME/conf/server.xml >> $a


echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.1 Ensure Web content directory is on a separate partition from the Tomcat system files\n" >> $a
df $CATALINA_HOME/webapps >> $a
df $CATALINA_HOME >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.2 Restrict access to the web administration application\n" >> $a
cat $CATALINA_HOME/conf/server.xml | grep -e "^<Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127" >> $a


echo -e "\n==========================================================================================\n" >> $a


echo -e "\n10.3 Restrict manager application\n" >> $a
cat $CATALINA_BASE/conf/$enginename/$hostname/manager.xml | grep -e "^<Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"127" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.4 Force SSL when accessing the manager application\n" >> $a
grep transport-guarantee $CATALINA_HOME/webapps/manager/WEB-INF/web.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.5 Rename the manager application\n" >> $a
File2=$CATALINA_HOME/conf/Catalina/localhost/manager.xml
File3=$CATALINA_HOME/webapps/host-manager/manager.xml
File4=$CATALINA_HOME/webapps/manager
File5=$CATALINA_HOME/webapps/manager
if [ -f "$FILE2" ]; then
    echo "$FILE2 exist"
fi
if [ -f "$FILE3" ]; then
    echo "$FILE3 exist"
fi
if [ -f "$FILE4" ]; then
    echo "$FILE4 exist"
fi
if [ -f "$FILE5" ]; then
    echo "$FILE5 exist"
fi

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.6 Enable strict servlet Compliance\n" >> $a
cat $CATALINA_HOME/bin/catalina.sh | grep "Dorg.apache.catalina.STRICT_SERVLET_COMPLIANCE=true" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.7 Turn off session facade recycling\n" >> $a
cat $CATALINA_HOME/bin/catalina.sh | grep "Dorg.apache.catalina.connector.RECYCLE_FACADES=true" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.8 Do not allow additional path delimiters\n" >> $a
cat $CATALINA_HOME/bin/catalina.sh | grep "Dorg.apache.catalina.connector.CoyoteAdapter.ALLOW_BACKSLASH=false" >> $a
cat $CATALINA_HOME/bin/catalina.sh | grep "Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=false" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.9 Configure connectionTimeout\n" >> $a
grep connectionTimeout $CATALINA_HOME/conf/server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.10 Configure maxHttpHeaderSize\n" >> $a
grep maxHttpHeaderSize $CATALINA_HOME/conf/server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.11 Force SSL for all applications\n" >> $a
grep transport-guarantee $CATALINA_HOME/conf/web.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.12 Do not allow symbolic linking\n" >> $a
find . -name context.xml | xargs grep "allowLinking" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.13 Do not run applications as privileged\n" >> $a
find . -name context.xml | xargs grep "privileged" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.14 Do not allow cross context requests\n" >> $a
find . -name context.xml | xargs grep "crossContext" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.15 Do not resolve hosts on logging valves\n" >> $a
grep enableLookups $CATALINA_HOME/conf/server.xml >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.16 Enable memory leak listener\n" >> $a
cat $CATALINA_HOME/conf/server.xml | grep -e "^<Listener className=\"org.apache.catalina.core.JreMemoryLeakPreventionListener" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.17 Setting Security Lifecycle Listener\n" >> $a
echo -e "\nManual Test Required\n" >> $a

echo -e "\n==========================================================================================\n" >> $a
echo -e "\n10.18 Use the logEffectiveWebXml and metadata-complete settings for deploying applications in production\n" >> $a
cat $CATALINA_HOME/webapps/$app/WEB-INF/web.xml | grep -e "metadata-complete=\"true\"" >> $a
cat $CATALINA_HOME/webapps/$app/META-INF/context.xml | grep -e "logEffectiveWebXml=\"true\"" >> $a

echo -e "\n==========================================================================================\n" >> $a








































