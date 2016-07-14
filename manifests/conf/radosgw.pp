# Define a radosgw
#
define ceph::conf::radosgw (
  $keystone_url,
  $keystone_admin_token,
  $keystone_accepted_roles = 'Member, admin, swiftoperator',
  $keystone_token_cache_size = 500,
  $keystone_revocation_interval = 600,
  $nss_db_path = '/var/lib/ceph/nss',
  $keyring = '/etc/ceph/keyring',
  $socket = '/var/run/ceph/radosgw.sock',
  $logfile = '/var/log/ceph/radosgw.log',
  $ceph_radosgw_listen_ssl = false,
  $rgw_multipart_min_part_size = 1048576,
  $debug_rgw ,
  $rgw_obj_stripe_size ,
  $rgw_thread_pool_size ,
  $rgw_bucket_index_shards ,
  $rgw_frontends ,
  $rgw_cors_allowed_origin ,
  $rgw_keystone_sign_api,
  $rgw_keystone_token_api,
  $rgw_multipart_part_upload_limit,
) {

  ceph_config {
    'client.radosgw.gateway/host':  value => $::hostname, tag => "radosgw_config";
    'client.radosgw.gateway/keyring':  value => $keyring, tag => "radosgw_config";
    'client.radosgw.gateway/rgw socket path':  value => $socket, tag => "radosgw_config";
    'client.radosgw.gateway/log file':  value => $logfile, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone url':  value => $keystone_url, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone sign api': value => $rgw_keystone_sign_api, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone token api': value => $rgw_keystone_token_api, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone accepted roles':  value => $keystone_accepted_roles, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone token cache size':  value => $keystone_token_cache_size, tag => "radosgw_config";
    'client.radosgw.gateway/rgw keystone revocation interval':  value => $keystone_revocation_interval, tag => "radosgw_config";
    'client.radosgw.gateway/rgw s3 auth use keystone':  value => 'true', tag => "radosgw_config";
    'client.radosgw.gateway/rgw multipart min part size':  value => $rgw_multipart_min_part_size, tag => "radosgw_config";

    'client.radosgw.gateway/rgw thread pool size': value => $rgw_thread_pool_size, tag => 'rgw_config';
    'client.radosgw.gateway/rgw override bucket index max shards': value => $rgw_bucket_index_shards, tag => "radosgw_config";
    'client.radosgw.gateway/debug rgw': value => $debug_rgw, tag => "radosgw_config";
    'client.radosgw.gateway/rgw obj stripe size': value => $rgw_obj_stripe_size, tag => "rgw_config";
    'client.radosgw.gateway/rgw frontends': value => $rgw_frontends, tag => "rgw_config";
    'client.radosgw.gateway/rgw cors allowed origin': value => $rgw_cors_allowed_origin, tag => "rgw_config";
    'client.radosgw.gateway/rgw multipart part upload limit': value => $rgw_multipart_part_upload_limit, tag => "rgw_config"
  }

  if $ceph_radosgw_listen_ssl {
    ceph_config {
      'client.radosgw.gateway/nss db path': value => $nss_db_path;
    }
  }
}
