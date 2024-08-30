<?php
defined('_VALID') or die('Restricted Access!');

require $config['BASE_DIR']. '/classes/filter.class.php';
require $config['BASE_DIR']. '/include/adodb/adodb.inc.php';
require $config['BASE_DIR']. '/include/dbconn.php';

$response = array('status' => 0, 'msg' => '', 'debug' => '');

if ( isset($_POST['friend_id']) ) {
    if ( isset($_SESSION['uid']) ) {
        $filter     = new VFilter();
        $uid        = intval($_SESSION['uid']);
        $fid        = $filter->get('friend_id', 'INTEGER');
        $sql        = "SELECT UID FROM friends WHERE UID = " .$uid. " AND FID = " .$fid. " AND status = 'Pending' LIMIT 1";
        $conn->execute($sql);
        if ( $conn->Affected_Rows() == 1 ) {
            $sql            = "DELETE FROM friends WHERE UID = " .$uid. " AND FID = " .$fid. " LIMIT 1";
            $conn->execute($sql);
            $sql            = "UPDATE signup SET total_friends = total_friends-1, popularity = popularity-2 WHERE UID = " .$uid. " LIMIT 1";
            $conn->execute($sql);
            $sql            = "UPDATE signup SET points = points-2 WHERE UID = " .$fid. " LIMIT 1";
            $conn->execute($sql);
			$response['msg'] = $lang['ajax.reject_friend_success'];
			$response['status'] = 1;
            $sql            = "SELECT u.username, u.email, p.friend_request FROM signup AS u, users_prefs AS p 
                               WHERE u.UID = " .$fid. " AND u.UID = p.UID LIMIT 1";
            $rs             = $conn->execute($sql);
            if ( $conn->Affected_Rows() === 1 && $rs->fields['friend_request'] == '1' ) {
                $to         = $rs->fields['email'];
                $receiver   = $rs->fields['username'];
                $sql        = "SELECT username FROM signup WHERE UID = " .$uid. " LIMIT 1";
                $rs         = $conn->execute($sql);
                if ( $conn->Affected_Rows() === 1 ) {
                    $username 	= $rs->fields['username'];
                    require $config['BASE_DIR']. '/classes/email.class.php';
					$mail		= new VMail();
					$search		= array('{$site_title}', '{$username}', '{$baseurl}', '{$site_name}', '{$receiver}');
					$replace	= array($config['site_title'], $username, $config['BASE_URL'], $config['site_name'], $receiver);
					$mail->sendPredefined($to, 'request_rejected', $search, $replace);
                }
            }
        } else {
			$response['msg'] = $lang['ajax.reject_friend_missing'];
		}
    } else {
		$response['msg'] = $lang['ajax.reject_friend_login'];
	}
} else {
	$response['msg'] = 'Invalid request!?';
}
echo json_encode($response);
die();
?>
