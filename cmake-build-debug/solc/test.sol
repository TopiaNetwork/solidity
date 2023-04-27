// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {

    function db_create(string memory key, uint value) public returns (uint) {
        uint out = db.create(key, value);
        return out;
    }
    function db_query(string memory key) public returns (uint) {
        uint out = db.query(key);
        return out;
    }
    function db_delete(string memory key) public returns (uint) {
        uint out = db.del(key);
        return out;
    }
    function db_update(string memory key, uint value) public returns (uint) {
        uint out = db.update(key, value);
        return out;
    }
}