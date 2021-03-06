/*******************************************************************************

    User-facing API for the client's Get request.

    Copyright:
        Copyright (c) 2017 sociomantic labs GmbH. All rights reserved

    License:
        Boost Software License Version 1.0. See LICENSE.txt for details.

*******************************************************************************/

module integrationtest.neo.client.request.Get;

import ocean.transition;
import ocean.core.SmartUnion;
import swarm.neo.client.NotifierTypes;

/*******************************************************************************

    Request-specific arguments provided by the user and passed to the notifier.

*******************************************************************************/

public struct Args
{
    hash_t key;
}

/*******************************************************************************

    Union of possible notifications.

*******************************************************************************/

private union NotificationUnion
{
    /// The request succeeded, but no record was present.
    NoInfo nothing;

    /// The request succeeded and a value was retrieved.
    RequestDataInfo received;

    /// The request was tried and failed due to a connection error.
    RequestNodeExceptionInfo node_disconnected;

    /// The request was tried and failed due to an internal node error.
    RequestNodeInfo node_error;

    /// The request was tried and failed because it is unsupported.
    RequestNodeUnsupportedInfo unsupported;

    /// The request failed for an unknown reason, presumably an internal error.
    NoInfo error;
}

/*******************************************************************************

    Notification smart union.

*******************************************************************************/

public alias SmartUnion!(NotificationUnion) Notification;

/*******************************************************************************

    Type of notifcation delegate.

*******************************************************************************/

public alias void delegate ( Notification, Args ) Notifier;
