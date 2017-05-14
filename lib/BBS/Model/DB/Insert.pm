package BBS::Model::DB::Insert;

use strict;
use warnings;
use utf8;

use Mouse;
with 'BBS::Model::DB';

# thread(
#     name => "thread_name",
#     category => "category_name"
# );
sub thread {
    my $self = shift;
    my %args = @_;

    my $sth = $self->dbh->prepare("insert into thread (name, category, created_at) values (?, ?, 'now()')");
    $sth->execute($args{name}, $args{category}) or die "Could not insert values: $!";

    my $is_success = $sth->row;
    $sth->finish;
    
    return $is_success;
}

# message(
#     posted_by  => "name",
#     email      => "abc@example.com",
#     text       => "text",
# )
sub message {
    my $self = shift;
    my %args = @_;

    my $sth = $self->dbh->prepare(<<"__SQL__");
insert into message (posted_by, email, text, created_at, updated_at)
values (?, ?, ?, 'now()', 'now()')
__SQL__

    $sth->execute($args{posted_by}, $args{email}, $args{text}) or die "Could not insert values: $!";

    my $is_success = $sth->row;
    $sth->finish;
    
    return $is_success;
}

__PACKAGE__->meta->make_immutable;

1;