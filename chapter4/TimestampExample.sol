pragma solidity ^0.8.0;

contract TimestampExample {
    // 存储上次更新的时间戳
    uint256 public lastUpdate;

    // 事件：记录时间更新
    event TimeUpdated(uint256 newTimestamp, string unit);

    // 构造函数：初始化时设置当前时间
    constructor() {
        lastUpdate = block.timestamp;
        emit TimeUpdated(lastUpdate, "seconds");
    }

    // 获取当前时间戳（秒）
    function getCurrentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    // 更新时间戳
    function updateTimestamp() public {
        lastUpdate = block.timestamp;
        emit TimeUpdated(lastUpdate, "seconds");
    }

    // 检查自上次更新是否经过指定时间
    function hasTimePassed(uint256 _seconds) public view returns (bool) {
        return block.timestamp >= lastUpdate + _seconds;
    }

    // 时间单位转换示例
    function timeUnitExamples()
        public
        view
        returns (
            uint256 secondsExample,
            uint256 minutesExample,
            uint256 hoursExample,
            uint256 daysExample,
            uint256 weeksExample
        )
    {
        // 当前时间戳
        uint256 currentTime = block.timestamp;

        // 演示时间单位
        secondsExample = currentTime + 30 seconds; // 加30秒
        minutesExample = currentTime + 5 minutes; // 加5分钟
        hoursExample = currentTime + 2 hours; // 加2小时
        daysExample = currentTime + 1 days; // 加1天
        weeksExample = currentTime + 1 weeks; // 加1周

        return (
            secondsExample,
            minutesExample,
            hoursExample,
            daysExample,
            weeksExample
        );
    }

    // 计算距离未来的剩余时间
    function timeUntil(
        uint256 futureTimestamp
    )
        public
        view
        returns (
            uint256 secondsLeft,
            uint256 minutesLeft,
            uint256 hoursLeft,
            uint256 daysLeft,
            uint256 weeksLeft
        )
    {
        require(futureTimestamp > block.timestamp, "Future timestamp required");

        uint256 timeDiff = futureTimestamp - block.timestamp;

        secondsLeft = timeDiff;
        minutesLeft = timeDiff / 1 minutes;
        hoursLeft = timeDiff / 1 hours;
        daysLeft = timeDiff / 1 days;
        weeksLeft = timeDiff / 1 weeks;

        return (secondsLeft, minutesLeft, hoursLeft, daysLeft, weeksLeft);
    }
}
