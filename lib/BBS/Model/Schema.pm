package BBS::Model::Schema;
use DBIx::Schema::DSL;

database 'PostgreSQL';

create_table 'thread' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    varchar   'name',       not_null;
    varchar   'category',   not_null;
    timestamp 'created_at', not_null, default => 'now()';

    has_many 'writer';

    add_index 'category_idx' => ['category'];
};

create_table 'writer' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    integer   'thread_id',  primary_key;
    varchar   'name',       not_null;
    varchar   'email',      not_null, size => 40;
    timestamp 'created_at', not_null, default => 'now()';

    # 外部キーの制約を行うことで, thread.id に格納さている
    # id 以外の数値を writer.thread_id へ格納することができない
    belongs_to 'thread';

    has_many 'message';

    add_index 'thread_id_idx' => ['thread_id'];
};

create_table 'message' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    integer   'writer_id',  primary_key;
    text      'text',       not_null;
    tinyint   'abone',      not_null, default => 0;
    timestamp 'created_at', not_null, default => 'now()';
    timestamp 'updated_at', not_null, default => 'now()';

    belongs_to 'writer';

    add_index 'message_id_idx' => ['id'];
};

1;