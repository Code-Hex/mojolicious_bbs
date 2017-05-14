package BBS;
use Mojo::Base 'Mojolicious';
use String::Random;
use Mojolicious::Plugin::CSRFDefender;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Load configuration from hash returned by "my_app.conf"
    my $config = $self->plugin('Config' => +{file => 'etc/bbs.conf'});

    # For CSRF
    $self->plugin('Mojolicious::Plugin::CSRFDefender');

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('example#welcome');
    $self->app->secret(String::Random->new->randregex('[A-Za-z0-9]{32}'));
    $self->sessions->secure(1); # You can use secure cookie
}

1;
