   #include <string>
   #include <ros/ros.h>
   #include <sensor_msgs/JointState.h>
   #include <tf/transform_broadcaster.h>
   
   int main(int argc, char** argv) {
      ros::init(argc, argv, "state_publisher");
      ros::NodeHandle n;
       ros::Publisher joint_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
       tf::TransformBroadcaster broadcaster;
       ros::Rate loop_rate(30);
   
       const double degree = M_PI/180;
   
       // robot state
       //double tilt = 0, tinc = degree, swivel=0, angle=0, height=0, hinc=0.005;
       double joint1 = 0, joint2 = 0, joint3 = 0, angle = 0, hinc = degree, tinc = degree;
   
       // message declarations
       geometry_msgs::TransformStamped odom_trans;
       sensor_msgs::JointState joint_state;
       odom_trans.header.frame_id = "odom";
       odom_trans.child_frame_id = "axis";
      
	   while(ros::ok() && joint1 < 1.53){
	   //update joint_state
           joint_state.header.stamp = ros::Time::now();
           joint_state.name.resize(3);
           joint_state.position.resize(3);
           joint_state.name[0] ="joint1";
           joint_state.position[0] = joint1;
           joint_state.name[1] ="joint2";
           joint_state.position[1] = joint2;
           joint_state.name[2] ="joint3";
           joint_state.position[2] = joint3;

	   // update transform
           // (moving in a circle with radius=2)
           odom_trans.header.stamp = ros::Time::now();
           odom_trans.transform.translation.x = cos(angle)*2;
           odom_trans.transform.translation.y = sin(angle)*2;
           odom_trans.transform.translation.z = .7;
           odom_trans.transform.rotation = tf::createQuaternionMsgFromYaw(angle+M_PI/2);
           
	   //send the joint state and transform
           joint_pub.publish(joint_state);
           broadcaster.sendTransform(odom_trans);
   	   joint1 += tinc;
	   loop_rate.sleep();
	   }
	   while(ros::ok() && joint3 > 0.85){
	   //update joint_state
           joint_state.header.stamp = ros::Time::now();
           joint_state.name.resize(3);
           joint_state.position.resize(3);
           joint_state.name[0] ="joint1";
           joint_state.position[0] = joint1;
           joint_state.name[1] ="joint2";
           joint_state.position[1] = joint2;
           joint_state.name[2] ="joint3";
           joint_state.position[2] = joint3;

	   // update transform
           // (moving in a circle with radius=2)
           odom_trans.header.stamp = ros::Time::now();
           odom_trans.transform.translation.x = cos(angle)*2;
           odom_trans.transform.translation.y = sin(angle)*2;
           odom_trans.transform.translation.z = .7;
           odom_trans.transform.rotation = tf::createQuaternionMsgFromYaw(angle+M_PI/2);
           
	   //send the joint state and transform
           joint_pub.publish(joint_state);
           broadcaster.sendTransform(odom_trans);
   	   joint1 -= tinc;
	   loop_rate.sleep();
	   }
	
   
   
       return 0;
   }
