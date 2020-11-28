   #include <string>
   #include <ros/ros.h>
   #include <sensor_msgs/JointState.h>
   
   int main(int argc, char** argv) {
      ros::init(argc, argv, "state_publisher");
      ros::NodeHandle n;
       ros::Publisher joint_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
       ros::Rate loop_rate(60);
   
       const double degree = M_PI/180;
   
       // robot state
       double joint1 = 0, joint2 = 0, joint3 = 0, tinc = degree;
   
       // message declarations
       sensor_msgs::JointState joint_state;

       while(ros::ok()){
	   //update joint_state  && !( )
           joint_state.header.stamp = ros::Time::now();
           joint_state.name.resize(3);
           joint_state.position.resize(3);
           joint_state.name[0] ="joint1";
           joint_state.position[0] = joint1;
           joint_state.name[1] ="joint2";
           joint_state.position[1] = joint2;
           joint_state.name[2] ="joint3";
           joint_state.position[2] = joint3;
   
           // send the joint state and transform
           joint_pub.publish(joint_state);
   
           // Create new robot state
           
           if (joint1 < 1.53) joint1 += tinc;
           if (joint3 > -0.85) joint3 -= tinc;
	   
	   if(joint1 >= 1.53 && joint3 <=-0.85) break;
   
           // This will adjust as needed per iteration
           loop_rate.sleep();

	
	}
	
       return 0;
   }
