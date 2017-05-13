package BBS::Model::Schema;
use DBIx::Schema::DSL;

database 'PostgreSQL';

create_table 'thread' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    varchar   'name',       not_null;
    varchar   'category',   not_null;
    timestamp 'created_at', not_null;

    has_many 'writer';

    add_index 'category_idx' => ['category'];
};

create_table 'writer' => columns {
    integer   'thread_id',  primary_key;
    varchar   'id',         not_null, size => 25;
    varchar   'name',       not_null;
    varchar   'email',      not_null, size => 40;
    text      'message',    not_null;
    timestamp 'created_at', not_null;

    # 外部キーの制約を行うことで, thread.id に格納さている
    # id 以外の数値を writer.thread_id へ格納することができない
    belongs_to 'thread';

    add_index 'thread_id_idx' => ['thread_id'];
};

1;