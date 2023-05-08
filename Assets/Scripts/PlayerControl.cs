using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This script is a basic 2D character controller that allows
// the player to run and jump. It uses Unity's new input system,
// which needs to be set up accordingly for directional movement
// and jumping buttons.

[RequireComponent(typeof(BoxCollider2D))]
[RequireComponent(typeof(Rigidbody2D))]
public class PlayerControl : MonoBehaviour
{

    [Header("Movement Params")]
    public float runSpeed = 6.0f;
    //public float jumpSpeed = 8.0f;
    public float gravityScale = 20.0f;

    // components attached to player
    private BoxCollider2D coll;
    private Rigidbody2D rb;

    // other
    // private bool isGrounded = false;

    private void Awake()
    {
        coll = GetComponent<BoxCollider2D>();
        rb = GetComponent<Rigidbody2D>();

        rb.gravityScale = gravityScale;
    }

    private void FixedUpdate()
    {
       if (DialogueManager.GetInstance().dialogueIsPlaying)
        {
            return;
        }

        CalculateMovement();
    }

    void CalculateMovement()
    {
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        transform.position = new Vector3(Mathf.Clamp(transform.position.x, -8.0f, 8.0f), Mathf.Clamp(transform.position.y, -3.8f, 3.8f), 0);

        Vector3 movementDirection = new Vector3(horizontalInput, verticalInput, 0);
        float inputMagnitude = Mathf.Clamp01(movementDirection.magnitude);
        movementDirection.Normalize();


        transform.Translate(movementDirection * runSpeed * inputMagnitude * Time.deltaTime, Space.World);

    }

}
