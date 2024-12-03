using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TankControls : MonoBehaviour
{
    private string moveInputAxis = "Vertical";
    private string turnInputAxis = "Horizontal";
    private Vector3 moveVector = Vector3.zero;

    public CharacterController characterController;
    public float rotationrate = 230;
    public float speed = 0.03f;
    public float gravitySpeed = 9.81f;
    //public float jumpSpeed = 10f;

    // Update is called once per frame
    void Update()
    {
        float moveAxis = Input.GetAxis(moveInputAxis);
        float turnAxis = Input.GetAxis(turnInputAxis);
        float verticalVelocity = characterController.velocity.y - gravitySpeed * Time.deltaTime;

        ApplyInput(moveAxis, turnAxis);
        Gravity(verticalVelocity);

    }
    private void ApplyInput(float moveinput, float turninput)
    {
        Move(moveinput);
        Turn(turninput);

    }
    private void Move(float input)
    {
        characterController.Move(transform.rotation * Vector3.forward * input * speed);
        //Apply some dampening force
        //transform.Translate(Vector3.forward * input * speed);
    }
    private void Gravity(float vVel)
    {
        moveVector.y = vVel * Time.deltaTime;
        characterController.Move(moveVector);
    }

    private void Turn(float input)
    {

        transform.Rotate(0f, input * rotationrate * Time.deltaTime, 0f);
    }
}

