// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; // 需支持 EIP-1153

contract TransientStorageExample {
    // Transient Storage 插槽（任意选择，示例用 0）
    uint256 constant TRANSIENT_SLOT = 0;

    // 只是示例代码，实际中这里可能重入导致无法得到期待的值，因为可能在其他地方清除了值
    function setTransientValue(uint256 value) external {
        // 使用内联汇编写入 Transient Storage
        assembly {
            tstore(TRANSIENT_SLOT, value)
        }
    }

    function getTransientValue() external view returns (uint256) {
        // 使用内联汇编读取 Transient Storage
        uint256 value;
        assembly {
            value := tload(TRANSIENT_SLOT)
        }
        return value;
    }

    // 示例：防止重入攻击
    function nonReentrantCall(
        address target,
        uint256 value
    ) external returns (bool, bytes memory) {
        // 检查临时锁
        uint256 lock;
        assembly {
            lock := tload(TRANSIENT_SLOT)
        }
        require(lock == 0, "Reentrancy check");

        // 设置临时锁
        assembly {
            tstore(TRANSIENT_SLOT, 1)
        }

        // 执行低级调用
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", value);
        (bool success, bytes memory result) = target.call(data);

        // 清除临时锁
        assembly {
            tstore(TRANSIENT_SLOT, 0)
        }

        require(success, "Call failed");
        return (success, result);
    }
}
