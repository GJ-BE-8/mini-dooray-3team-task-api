-- users 테이블 생성
CREATE TABLE users (
    user_id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    created_at DATETIME,
    UNIQUE (email)
);

-- Project 테이블 생성
CREATE TABLE Project (
    project_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    status VARCHAR(20),
    created_at DATETIME
);

-- Project 상태 제약 조건 추가
ALTER TABLE Project
ADD CONSTRAINT chk_project_status CHECK (status IN ('ACTIVE', 'SLEEP', 'CLOSED'));

-- MileStone 테이블 생성
CREATE TABLE MileStone (
    milestone_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    status VARCHAR(20),
    created_at DATETIME
);

-- MileStone 상태 제약 조건 추가
ALTER TABLE MileStone
ADD CONSTRAINT chk_milestone_status CHECK (status IN ('START', 'PROGRESS', 'END'));

-- project_members 테이블 생성
CREATE TABLE project_members (
    project_member_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT,
    user_id VARCHAR(255),
    role VARCHAR(20),
    FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- project_members 역할 제약 조건 추가
ALTER TABLE project_members
ADD CONSTRAINT chk_project_member_role CHECK (role IN ('MEMBER', 'ADMIN'));

-- Task 테이블 생성
CREATE TABLE Task (
    task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT,
    milestone_id BIGINT,
    project_member_id BIGINT,
    title VARCHAR(255),
    description TEXT,
    created_at DATETIME,
    FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (milestone_id) REFERENCES MileStone(milestone_id) ON DELETE SET NULL,
    FOREIGN KEY (project_member_id) REFERENCES project_members(project_member_id) ON DELETE SET NULL
);

-- Comment 테이블 생성
CREATE TABLE Comment (
    comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    task_id BIGINT NOT NULL,
    project_member_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    FOREIGN KEY (task_id) REFERENCES Task(task_id) ON DELETE CASCADE,
    FOREIGN KEY (project_member_id) REFERENCES project_members(project_member_id) ON DELETE CASCADE
);

-- Tag 테이블 생성
CREATE TABLE Tag (
    tag_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- TaskTag 테이블 생성
CREATE TABLE TaskTag (
    task_tag_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    task_id BIGINT,
    tag_id BIGINT,
    FOREIGN KEY (task_id) REFERENCES Task(task_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tag(tag_id) ON DELETE CASCADE
);
