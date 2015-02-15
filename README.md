# Docker Puppet Spec

This container will be use to run puppet module spec test based on the information provided by the file '.ci.yml' or file using the same syntax (eg: .travis.yml, ...) located in the puppet module directory.

For now only the keys env, language, rvm, gemfile, before_install, install, before_script, script and matrix (exclude) are supported in the configuration file. Others keys will be ignore.

Here is an example of the file '.ci.yml':

```
---
env:
- PUPPET_VERSION=3.3.2
- PUPPET_VERSION=3.4.2
- PUPPET_VERSION=3.5.1
- PUPPET_VERSION=3.6.0
language: ruby
rvm:
- 1.8.7
- 1.9.3
- 2.0.0
gemfile: Gemfile
before_script: 'gem install --no-ri --no-rdoc bundler'
script: 'bundle exec rake validate && bundle exec rake lint && bundle exec rake validate_readme && SPEC_OPTS="--format documentation" bundle exec rake spec'
matrix:
  exclude:
    - rvm: 1.8.7
      env: PUPPET_VERSION=3.3.2
```

A command ([puppet_spec_docker](https://github.com/juliengk/docker-puppet-spec/tree/master/bin)) is provided to generate the docker command to run the spec test with all the combination possible for Puppet and Ruby version.

```
$ bin/puppet_spec_docker -h
Usage: puppet_spec_docker [options] [arguments...]

Specific options:
    -b, --branch BRANCH              Branch master
    -c, --config FILE                File .ci.yml
    -i, --image IMAGE                Image kassis/puppet-spec
    -p, --proxy PROXY                Proxy URL http://proxy.example.net:8080
    -s, --storage STORAGE            Path to the directory where to save the content of /usr/local/rvm in the container
```

By default the command will look for the configuration file '.ci.yml' in the current directory. That can be changed with the switch -c /path/to/conf/yml.

The image used can be changed as well if you have built your own.

A proxy can be specified if you are behind one in order to be able to download ruby version and / or gems.

To avoid to download the same version of ruby and / or gems while running the spec test, datas can be store on the docker host and reuse.

# Quick start

The fastest way to get running:

 * [install docker](https://docs.docker.com/installation/#installation)
 * download image: `docker pull kassis/puppet-spec`



```
$ bin/puppet_spec_docker -c /path/to/puppet/module/.ci.yml
```

```
## PUPPET_VERSION=3.3.2 RVM=1.9.3 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -r 1

## PUPPET_VERSION=3.3.2 RVM=2.0.0 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -r 2

## PUPPET_VERSION=3.4.2 RVM=1.8.7 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 1

## PUPPET_VERSION=3.4.2 RVM=1.9.3 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 1 -r 1

## PUPPET_VERSION=3.4.2 RVM=2.0.0 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 1 -r 2

## PUPPET_VERSION=3.5.1 RVM=1.8.7 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 2

## PUPPET_VERSION=3.5.1 RVM=1.9.3 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 2 -r 1

## PUPPET_VERSION=3.5.1 RVM=2.0.0 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 2 -r 2

## PUPPET_VERSION=3.6.0 RVM=1.8.7 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 3

## PUPPET_VERSION=3.6.0 RVM=1.9.3 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 3 -r 1

## PUPPET_VERSION=3.6.0 RVM=2.0.0 GEMFILE=Gemfile
docker run -t -i -v /path/to/puppet/module:/srv/module kassis/puppet-spec -p 3 -r 2
```

Pick the versions that you want to test and run it:

```
$ docker run -t -i \
         -v /path/to/puppet/module:/srv/module \
         kassis/puppet-spec
```

# User Feedback

# Issues

If you have any problems with or questions about this image, please contact us through a [GitHub](https://github.com/juliengk/docker-puppet-spec/issues) issue.
