// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract a {
    function getLargeValue(string memory key) public returns (string memory) {
        uint256 offset;
        uint256 length;
        uint256 resOffset;
        uint256 resLength;
        uint256 memOffset;

        assembly {
         // 调用dbtest函数
            offset := add(key, 0x20)
            length := mload(key)
            memOffset := mload(0x40)
            resOffset, resLength := dbtest(memOffset, offset, length)
            mstore(0x40, add(memOffset, resLength)) // 更新空闲内存指针

         // 获取内存偏移量和长度
            offset := resOffset
            length := resLength
        }

        return getStringFromMemory(offset, length);
    }

    function getStringFromMemory(uint256 offset, uint256 length) private pure returns (string memory) {
        // 从内存中读取较大的VALUE
        bytes memory valueBytes = new bytes(length);
        for (uint256 i = 0; i < length; i++) {
            bytes1 b;
            assembly {
                b := mload(add(offset, i))
            }
            valueBytes[i] = b;
        }

        // 将bytes转换为string并返回
        return string(valueBytes);
    }

    function g(string memory key) public returns (string memory) {
        string memory out = getLargeValue(key);
        return out;
    }
}