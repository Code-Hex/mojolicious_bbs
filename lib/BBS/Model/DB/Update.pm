package BBS::Model::DB::Update;

use strict;
use warnings;
use utf8;

use Mouse;
with 'BBS::Model::DB'

# abone(id => 1)
sub abone {
    my $self = shift;
    my %args = @_;

     my $sth = $self->dbh->prepare("update message set abone = 1 where id = ?");
    $sth->execute($args{id}) or die "Could not update abone: $!";

    my $is_success = $sth->row;
    $sth->finish;
    
    return $is_success;
}

1;