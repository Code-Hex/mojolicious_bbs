package BBS::Model::Schema;
use DBIx::Schema::DSL;

database 'PostgreSQL';

create_table 'thread' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    varchar   'name',       not_null;
    varchar   'category',   not_null;
    timestamp 'created_at', not_null;

    has_many 'message';

    add_index 'category_idx' => ['category'];
};

create_table 'message' => columns {
    integer   'id',         primary_key, unsigned, auto_increment;
    varchar   'posted_by',  not_null;
    varchar   'email',      not_null;
    text      'text',       not_null;
    tinyint   'abone',      not_null, default => 0;
    integer   'thread_id',  primary_key;
    timestamp 'created_at', not_null;
    timestamp 'updated_at', not_null;

    belongs_to 'thread';

    add_index 'message_id_idx' => ['id'];
};

1;