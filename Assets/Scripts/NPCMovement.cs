using System.Collections;
using System.Collections.Generic;
using UnityEngine; 
public class NPCMovement : MonoBehaviour
 
{
    internal Transform thisTransform;
    public Animator animator;
    public float moveSpeed = 0.2f;
    public Vector2 decisionTime = new Vector2(1, 4);
    internal float decisionTimeCount = 0;
    internal Vector3[] moveDirections = new Vector3[] { Vector3.right, Vector3.left, Vector3.zero};
    internal int currentMoveDirection;
    void Start()
    {
         // Cache the transform for quicker access
        thisTransform = this.transform;
        animator = GetComponent<Animator>();
        decisionTimeCount = Random.Range(decisionTime.x, decisionTime.y);
        ChooseMoveDirection();
    }
 
    // Update is called once per frame
    void Update()
    {
        if (DialogueManager.GetInstance().dialogueIsPlaying)
        {
            animator.SetInteger("AnimState", 0);
            return;
        }
        // Move the object in the chosen direction at the set speed
        Vector3 direction = moveDirections[currentMoveDirection];
        float xDir = direction.x;
        if(xDir > 0)
            GetComponent<SpriteRenderer>().flipX = false;
        else
            GetComponent<SpriteRenderer>().flipX = true;
        thisTransform.position += direction * Time.deltaTime * moveSpeed;
        if (animator && currentMoveDirection!=2)
        {
            animator.SetInteger("AnimState",1);
        }
        else
        {
            animator.SetInteger("AnimState",0);        
        }
 
        if (decisionTimeCount > 0) decisionTimeCount -= Time.deltaTime;
        else
        {
            decisionTimeCount = Random.Range(decisionTime.x, decisionTime.y);
            ChooseMoveDirection();
        }
    }
 
    void ChooseMoveDirection()
    {
        currentMoveDirection = Mathf.FloorToInt(Random.Range(0, moveDirections.Length)); 
    }
}
