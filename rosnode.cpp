#include "rosnode.h"

RosNode::RosNode(QObject *parent)
    : QObject{parent}, Node{"joy_qt"}, joy_name{"...."}
{
    spin_thread   = std::thread{ std::bind(&RosNode::rosSpin, this) };
    joy_name_sub  = this->create_subscription<stringMsg>("joy_name", 10, std::bind(&RosNode::setJoyName,
                                                                                  this, std::placeholders::_1));
    button_pub    = this->create_publisher<stringMsg>("button_state",10);
    ball_pub      = this->create_publisher<twistMsg>("ball_state",10);
}

RosNode::~RosNode() {
    rclcpp::shutdown();
}

void RosNode::rosSpin() {
    rclcpp::spin(this->get_node_base_interface());
    rclcpp::shutdown();
}

QString RosNode::getName() const {
    return name;
}


void RosNode::setName(const QString &newName){
    if (name == newName)
        return;
    name = newName;
    emit nameChanged();
}

void RosNode::setJoyName(const stringMsg::SharedPtr msg){
    joy_name = msg->data;
    QString temp_name = QString::fromStdString(joy_name);
    setName(temp_name);
}

void RosNode::buttonCallback(int number){
    auto msg = example_interfaces::msg::String();
    switch (number) {
    case 0:
        msg.data = "up";
        button_pub->publish(msg);
        break;
    case 1:
        msg.data = "down";
        button_pub->publish(msg);
        break;
    case 2:
        msg.data = "left";
        button_pub->publish(msg);
        break;
    case 3:
        msg.data = "right";
        button_pub->publish(msg);
        break;
    case 4:
        msg.data = "circle";
        button_pub->publish(msg);
        break;
    case 5:
        msg.data = "rectangle";
        button_pub->publish(msg);
        break;
    case 6:
        msg.data = "x";
        button_pub->publish(msg);
        break;
    case 7:
        msg.data = "triangle";
        button_pub->publish(msg);
        break;
    case 8:
        msg.data = "right hand mode ...";
        button_pub->publish(msg);
        break;

    case 9:
        msg.data = "left hand mode ...";
        button_pub->publish(msg);
        break;

    default:
        break;
    }
}

void RosNode::ballStateCallback(int x, int y){
    geometry_msgs::msg::Twist msg;
    qDebug() <<"x:" << x << "<-> y:" << y;
    msg.linear.x = x;
    msg.linear.y = y;
    ball_pub->publish(msg);
}
