#include "rosnode.h"

RosNode::RosNode(QObject *parent): QObject{parent}, Node{"joy_qt"}
{
    spin_thread = std::thread{ std::bind(&RosNode::rosSpin, this) };
    pub.button  = this->create_publisher<stringMsg>("button_state",10);
    pub.ball    = this->create_publisher<twistMsg>("ball_state",10);
}

RosNode::~RosNode() {
    rclcpp::shutdown();
}

void RosNode::rosSpin() {
    rclcpp::spin(this->get_node_base_interface());
    rclcpp::shutdown();
}

void RosNode::buttonCallback(int number){
    if(number > 9){
        return;
    }

    auto msg = example_interfaces::msg::String();
    msg.data = ros_message[number];
    pub.button->publish(msg);
}

void RosNode::ballStateCallback(int x, int y){
    geometry_msgs::msg::Twist msg;
    msg.linear.x = x;
    msg.linear.y = y;
    pub.ball->publish(msg);
}
