/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.shardingsphere.example.${feature?replace('-', '.')}.${framework?replace('-', '.')}.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.shardingsphere.example.${feature?replace('-', '.')}.${framework?replace('-', '.')}.entity.User;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface UserRepository {
    
    default void createTableIfNotExists() {
        createTableIfNotExistsNative();
        createTableIfNotExistsShadow();
    }

    void createTableIfNotExistsNative();

    void createTableIfNotExistsShadow();
    
    default void truncateTable() {
        truncateTableShadow();
        truncateTableNative();
    }

    void truncateTableNative();

    void truncateTableShadow();
    
    default void dropTable() {
        dropTableShadow();
        dropTableNative();
    }
    
    void insert(User user);

    void dropTableNative();

    void dropTableShadow();
    
    default List<User> selectAll() {
        List<User> result = new ArrayList<>();
        result.addAll(selectAllByUserType(0));
        result.addAll(selectAllByUserType(1));
        return result;
    }

    List<User> selectAllByUserType(int userType);
    
    default void delete(Long userId) {
        deleteByUserIdAndUserType(userId, (int) (userId % 2));
    }

    void deleteByUserIdAndUserType(@Param("userId") Long userId, @Param("userType") int userType);
}